import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../models/user.dart';
import 'storage_service.dart';

class ApiService {
  static ApiService? _instance;
  static ApiService get instance => _instance ??= ApiService._();
  
  ApiService._() {
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

    // 요청 인터셉터
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 인증 토큰 추가
        final token = StorageService.instance.getAuthToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        
        print('Request: ${options.method} ${options.path}');
        print('Headers: ${options.headers}');
        if (options.data != null) {
          print('Data: ${options.data}');
        }
        
        handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.statusMessage}');
        handler.next(response);
      },
      onError: (error, handler) {
        print('Error: ${error.message}');
        print('Response: ${error.response?.data}');
        handler.next(error);
      },
    ));
  }

  // 에러 처리 헬퍼
  Map<String, dynamic> _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      return {
        'success': false,
        'message': AppConstants.errorMessages['network_error'],
        'error_code': 'NETWORK_ERROR',
      };
    }

    if (error.response?.statusCode == 401) {
      // 토큰 만료 - 로그아웃 처리
      StorageService.instance.clearAuth();
      return {
        'success': false,
        'message': '인증이 만료되었습니다. 다시 로그인해주세요.',
        'error_code': 'UNAUTHORIZED',
      };
    }

    if (error.response?.statusCode == 500) {
      return {
        'success': false,
        'message': AppConstants.errorMessages['server_error'],
        'error_code': 'SERVER_ERROR',
      };
    }

    final responseData = error.response?.data;
    if (responseData is Map<String, dynamic>) {
      return {
        'success': false,
        'message': responseData['message'] ?? '알 수 없는 오류가 발생했습니다.',
        'error_code': responseData['error_code'] ?? 'UNKNOWN_ERROR',
      };
    }

    return {
      'success': false,
      'message': '알 수 없는 오류가 발생했습니다.',
      'error_code': 'UNKNOWN_ERROR',
    };
  }

  // 인증 API
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'username': username,
        'email': email,
        'password': password,
      });

      return {
        'success': true,
        'data': response.data,
        'message': AppConstants.successMessages['register_success'],
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final data = response.data;
      if (data['success'] == true) {
        // 토큰과 사용자 정보 저장
        await StorageService.instance.saveAuthToken(data['token']);
        await StorageService.instance.saveUserId(data['user']['id']);
        
        final user = User.fromJson(data['user']);
        await StorageService.instance.saveUserProfile(user);
      }

      return {
        'success': true,
        'data': data,
        'message': AppConstants.successMessages['login_success'],
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await _dio.post('/auth/logout');
      await StorageService.instance.clearAuth();
      
      return {
        'success': true,
        'message': '로그아웃되었습니다.',
      };
    } on DioException catch (e) {
      await StorageService.instance.clearAuth();
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> refreshToken() async {
    try {
      final response = await _dio.post('/auth/refresh');
      
      final data = response.data;
      if (data['success'] == true) {
        await StorageService.instance.saveAuthToken(data['token']);
      }

      return {
        'success': true,
        'data': data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // 사용자 API
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await _dio.get('/users/$userId');
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateUserProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.put('/users/$userId', data: data);
      
      return {
        'success': true,
        'data': response.data,
        'message': '프로필이 업데이트되었습니다.',
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      final response = await _dio.get('/users/$userId/stats');
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // 게임 API
  Future<Map<String, dynamic>> startSingleGame({
    required String difficulty,
  }) async {
    try {
      final response = await _dio.post('/game/start', data: {
        'mode': 'single',
        'difficulty': difficulty,
      });

      return {
        'success': true,
        'data': response.data,
        'message': AppConstants.successMessages['game_created'],
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getGameState(String gameId) async {
    try {
      final response = await _dio.get('/game/$gameId');
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> makeMove({
    required String gameId,
    required Map<String, dynamic> moveData,
  }) async {
    try {
      final response = await _dio.post('/game/$gameId/move', data: moveData);
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> endGame({
    required String gameId,
    required Map<String, dynamic> gameStats,
  }) async {
    try {
      final response = await _dio.post('/game/$gameId/end', data: gameStats);
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> saveGameStats(Map<String, dynamic> stats) async {
    try {
      final response = await _dio.post('/game/stats', data: stats);
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // 매칭 API
  Future<Map<String, dynamic>> requestMatching({
    required String gameMode,
    String? skillLevel,
  }) async {
    try {
      final response = await _dio.post('/matchmaking/request', data: {
        'game_mode': gameMode,
        'skill_level': skillLevel,
      });

      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> cancelMatching() async {
    try {
      final response = await _dio.delete('/matchmaking/cancel');
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // 방 API
  Future<Map<String, dynamic>> createRoom({
    required String name,
    required String gameMode,
    String? password,
    int? maxPlayers,
  }) async {
    try {
      final response = await _dio.post('/rooms', data: {
        'name': name,
        'game_mode': gameMode,
        'password': password,
        'max_players': maxPlayers,
      });

      return {
        'success': true,
        'data': response.data,
        'message': '방이 생성되었습니다.',
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> joinRoom({
    required String roomId,
    String? password,
  }) async {
    try {
      final response = await _dio.post('/rooms/$roomId/join', data: {
        'password': password,
      });

      return {
        'success': true,
        'data': response.data,
        'message': AppConstants.successMessages['room_joined'],
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> leaveRoom(String roomId) async {
    try {
      final response = await _dio.post('/rooms/$roomId/leave');
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getRoomList({
    int? page,
    int? limit,
    String? gameMode,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (page != null) queryParams['page'] = page;
      if (limit != null) queryParams['limit'] = limit;
      if (gameMode != null) queryParams['game_mode'] = gameMode;

      final response = await _dio.get('/rooms', queryParameters: queryParams);
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getRoomInfo(String roomId) async {
    try {
      final response = await _dio.get('/rooms/$roomId');
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // 리더보드 API
  Future<Map<String, dynamic>> getLeaderboard({
    String? gameMode,
    String? timeFrame,
    int? limit,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (gameMode != null) queryParams['game_mode'] = gameMode;
      if (timeFrame != null) queryParams['time_frame'] = timeFrame;
      if (limit != null) queryParams['limit'] = limit;

      final response = await _dio.get('/leaderboard', queryParameters: queryParams);
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // 헬스 체크
  Future<Map<String, dynamic>> healthCheck() async {
    try {
      final response = await _dio.get('/health');
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // 파일 업로드 (아바타 등)
  Future<Map<String, dynamic>> uploadFile({
    required String filePath,
    required String fileName,
    String? category,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
        if (category != null) 'category': category,
      });

      final response = await _dio.post('/upload', data: formData);
      
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
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

  // 재시도 로직이 있는 요청
  Future<Map<String, dynamic>> requestWithRetry(
    Future<Response> Function() request, {
    int maxRetries = AppConstants.maxRetries,
  }) async {
    int retryCount = 0;
    
    while (retryCount < maxRetries) {
      try {
        final response = await request();
        return {
          'success': true,
          'data': response.data,
        };
      } on DioException catch (e) {
        retryCount++;
        
        if (retryCount >= maxRetries ||
            e.response?.statusCode == 401 ||
            e.response?.statusCode == 403 ||
            e.response?.statusCode == 404) {
          return _handleError(e);
        }
        
        // 재시도 전 대기
        await Future.delayed(Duration(milliseconds: 1000 * retryCount));
      }
    }
    
    return {
      'success': false,
      'message': '최대 재시도 횟수를 초과했습니다.',
      'error_code': 'MAX_RETRIES_EXCEEDED',
    };
  }
}
