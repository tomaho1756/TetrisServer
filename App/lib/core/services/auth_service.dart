import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import '../models/user.dart';
import 'storage_service.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();
  AuthService._internal() {
    _initializeDio();
  }

  late final Dio _dio;

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl + AppConstants.apiPrefix,
      connectTimeout: AppConstants.connectionTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // 인터셉터 추가
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await StorageService.instance.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          // 토큰 만료 시 자동 로그아웃
          StorageService.instance.removeToken();
        }
        handler.next(error);
      },
    ));
  }

  // 현재 사용자 정보 가져오기 (AuthBloc에서 사용)
  Future<User?> getCurrentUser() async {
    try {
      final userId = await StorageService.instance.getUserId();
      if (userId == null) return null;

      final response = await _dio.get('/users/$userId');
      if (response.statusCode == 200) {
        return User.fromJson(response.data['user']);
      }
      return null;
    } catch (e) {
      print('Get current user error: $e');
      return null;
    }
  }

  // 로그인 (AuthBloc에서 사용)
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        // 토큰과 사용자 ID 저장
        await StorageService.instance.saveToken(data['token']);
        await StorageService.instance.saveUserId(data['user']['id']);
        
        return data;
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid request');
      } else {
        throw Exception('Network error');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  // 회원가입 (AuthBloc에서 사용)
  Future<Map<String, dynamic>> register(String email, String username, String password) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'email': email,
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        // 토큰과 사용자 ID 저장
        await StorageService.instance.saveToken(data['token']);
        await StorageService.instance.saveUserId(data['user']['id']);
        
        return data;
      } else {
        throw Exception('Registration failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('Email already exists');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid registration data');
      } else {
        throw Exception('Network error');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  // 로그아웃 (AuthBloc에서 사용)
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } catch (e) {
      print('Logout error: $e');
    } finally {
      await StorageService.instance.removeToken();
      await StorageService.instance.remove('user_id');
      await StorageService.instance.remove('user_data');
    }
  }

  // 토큰 갱신
  Future<bool> refreshToken() async {
    try {
      final response = await _dio.post('/auth/refresh');
      if (response.statusCode == 200) {
        final token = response.data['token'];
        await StorageService.instance.saveToken(token);
        return true;
      }
      return false;
    } catch (e) {
      print('Token refresh error: $e');
      return false;
    }
  }

  // 사용자 프로필 업데이트
  Future<User> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/users/$userId', data: data);
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['user']);
        await StorageService.instance.saveUserData(user.toJson());
        return user;
      } else {
        throw Exception('Profile update failed');
      }
    } catch (e) {
      throw Exception('Profile update error: $e');
    }
  }

  // 사용자 통계 가져오기
  Future<Map<String, dynamic>?> getUserStats(String userId) async {
    try {
      final response = await _dio.get('/users/$userId/stats');
      if (response.statusCode == 200) {
        return response.data['stats'];
      }
      return null;
    } catch (e) {
      print('Get user stats error: $e');
      return null;
    }
  }

  // 이메일 중복 확인
  Future<bool> checkEmailAvailability(String email) async {
    try {
      final response = await _dio.post('/auth/check-email', data: {'email': email});
      return response.data['available'] ?? false;
    } catch (e) {
      print('Email check error: $e');
      return false;
    }
  }

  // 사용자명 중복 확인
  Future<bool> checkUsernameAvailability(String username) async {
    try {
      final response = await _dio.post('/auth/check-username', data: {'username': username});
      return response.data['available'] ?? false;
    } catch (e) {
      print('Username check error: $e');
      return false;
    }
  }

  // 비밀번호 재설정 요청
  Future<bool> requestPasswordReset(String email) async {
    try {
      final response = await _dio.post('/auth/forgot-password', data: {'email': email});
      return response.statusCode == 200;
    } catch (e) {
      print('Password reset error: $e');
      return false;
    }
  }

  // 연결 테스트
  Future<bool> testConnection() async {
    try {
      final response = await _dio.get('/health');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // 계정 삭제
  Future<bool> deleteAccount(String userId) async {
    try {
      final response = await _dio.delete('/users/$userId');
      if (response.statusCode == 200) {
        await logout();
        return true;
      }
      return false;
    } catch (e) {
      print('Account deletion error: $e');
      return false;
    }
  }
}
