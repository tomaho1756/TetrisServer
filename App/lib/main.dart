import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'core/services/api_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/game_service.dart';
import 'core/services/socket_service.dart';
import 'core/services/audio_service.dart';
import 'core/services/storage_service.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/game/bloc/game_bloc.dart';
import 'features/settings/bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 세로 모드 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  // 상태바 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  
  // Hive 초기화
  await Hive.initFlutter();
  
  // 서비스 초기화
  await _initializeServices();
  
  runApp(const TetrisApp());
}

Future<void> _initializeServices() async {
  // 스토리지 서비스 초기화
  await StorageService.instance.init();
  
  // 오디오 서비스 초기화
  await AudioService.instance.init();
  
  // 설정 로드
  await SettingsService.instance.loadSettings();
}

class TetrisApp extends StatelessWidget {
  const TetrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authService: AuthService.instance,
            storageService: StorageService.instance,
          )..add(const AuthEvent.checkAuthStatus()),
        ),
        BlocProvider<GameBloc>(
          create: (context) => GameBloc(
            gameService: GameService.instance,
            socketService: SocketService.instance,
          ),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(
            storageService: StorageService.instance,
          )..add(const SettingsEvent.loadSettings()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return App(
            themeMode: settingsState.when(
              initial: () => ThemeMode.dark,
              loaded: (settings) => settings.themeMode,
              error: (_) => ThemeMode.dark,
            ),
          );
        },
      ),
    );
  }
}
