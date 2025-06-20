import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/game/screens/single_game_screen.dart';
import '../features/game/screens/multiplayer_lobby_screen.dart';
import '../features/game/screens/multiplayer_game_screen.dart';
import '../features/rooms/screens/room_list_screen.dart';
import '../features/rooms/screens/room_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/leaderboard/screens/leaderboard_screen.dart';
import '../features/settings/screens/settings_screen.dart';

class App extends StatelessWidget {
  final ThemeMode themeMode;

  const App({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tetris Multiplayer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
    );
  }

  static final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Auth
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      
      // Main
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      
      // Game
      GoRoute(
        path: '/game/single',
        name: 'single-game',
        builder: (context, state) {
          final difficulty = state.extra as String? ?? 'normal';
          return SingleGameScreen(difficulty: difficulty);
        },
      ),
      GoRoute(
        path: '/game/multiplayer/lobby',
        name: 'multiplayer-lobby',
        builder: (context, state) => const MultiplayerLobbyScreen(),
      ),
      GoRoute(
        path: '/game/multiplayer/:gameId',
        name: 'multiplayer-game',
        builder: (context, state) {
          final gameId = state.pathParameters['gameId']!;
          final isTeamMode = state.extra as bool? ?? false;
          return MultiplayerGameScreen(
            gameId: gameId,
            isTeamMode: isTeamMode,
          );
        },
      ),
      
      // Rooms
      GoRoute(
        path: '/rooms',
        name: 'rooms',
        builder: (context, state) => const RoomListScreen(),
      ),
      GoRoute(
        path: '/rooms/:roomId',
        name: 'room',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return RoomScreen(roomId: roomId);
        },
      ),
      
      // Profile & Leaderboard
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/leaderboard',
        name: 'leaderboard',
        builder: (context, state) => const LeaderboardScreen(),
      ),
      
      // Settings
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggedIn = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );
      
      final isOnAuthPage = state.fullPath == '/login' || 
                          state.fullPath == '/register';
      final isOnSplash = state.fullPath == '/splash';
      
      // 로그인 상태가 아니고 인증 페이지나 스플래시가 아니면 로그인으로
      if (!isLoggedIn && !isOnAuthPage && !isOnSplash) {
        return '/login';
      }
      
      // 로그인 상태이고 인증 페이지에 있으면 홈으로
      if (isLoggedIn && isOnAuthPage) {
        return '/home';
      }
      
      return null;
    },
  );
}
