import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../../core/models/user.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/storage_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final StorageService storageService;

  AuthBloc({
    required this.authService,
    required this.storageService,
  }) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        checkAuthStatus: () async {
          emit(const AuthState.loading());
          try {
            final token = await storageService.getToken();
            if (token != null) {
              final user = await authService.getCurrentUser();
              if (user != null) {
                emit(AuthState.authenticated(user));
              } else {
                emit(const AuthState.unauthenticated());
              }
            } else {
              emit(const AuthState.unauthenticated());
            }
          } catch (e) {
            emit(const AuthState.unauthenticated());
          }
        },
        login: (email, password) async {
          emit(const AuthState.loading());
          try {
            final response = await authService.login(email, password);
            await storageService.saveToken(response['token']);
            final user = User.fromJson(response['user']);
            emit(AuthState.authenticated(user));
          } catch (e) {
            emit(AuthState.error(e.toString()));
          }
        },
        register: (email, username, password) async {
          emit(const AuthState.loading());
          try {
            final response = await authService.register(email, username, password);
            await storageService.saveToken(response['token']);
            final user = User.fromJson(response['user']);
            emit(AuthState.authenticated(user));
          } catch (e) {
            emit(AuthState.error(e.toString()));
          }
        },
        logout: () async {
          emit(const AuthState.loading());
          try {
            await authService.logout();
            await storageService.removeToken();
            emit(const AuthState.unauthenticated());
          } catch (e) {
            emit(const AuthState.unauthenticated());
          }
        },
      );
    });
  }
}
