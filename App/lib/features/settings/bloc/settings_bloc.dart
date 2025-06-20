import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/services/storage_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final StorageService storageService;

  SettingsBloc({
    required this.storageService,
  }) : super(const SettingsState.initial()) {
    on<SettingsEvent>((event, emit) async {
      await event.when(
        loadSettings: () async {
          try {
            final settings = await _loadSettingsFromStorage();
            emit(SettingsState.loaded(settings));
          } catch (e) {
            emit(SettingsState.error(e.toString()));
          }
        },
        updateThemeMode: (themeMode) async {
          final currentState = state;
          if (currentState is _Loaded) {
            final updatedSettings = currentState.settings.copyWith(
              themeMode: themeMode,
            );
            await _saveSettingsToStorage(updatedSettings);
            emit(SettingsState.loaded(updatedSettings));
          }
        },
        updateSoundEnabled: (enabled) async {
          final currentState = state;
          if (currentState is _Loaded) {
            final updatedSettings = currentState.settings.copyWith(
              soundEnabled: enabled,
            );
            await _saveSettingsToStorage(updatedSettings);
            emit(SettingsState.loaded(updatedSettings));
          }
        },
        updateMusicEnabled: (enabled) async {
          final currentState = state;
          if (currentState is _Loaded) {
            final updatedSettings = currentState.settings.copyWith(
              musicEnabled: enabled,
            );
            await _saveSettingsToStorage(updatedSettings);
            emit(SettingsState.loaded(updatedSettings));
          }
        },
        updateVibrationEnabled: (enabled) async {
          final currentState = state;
          if (currentState is _Loaded) {
            final updatedSettings = currentState.settings.copyWith(
              vibrationEnabled: enabled,
            );
            await _saveSettingsToStorage(updatedSettings);
            emit(SettingsState.loaded(updatedSettings));
          }
        },
        updateShowGhost: (enabled) async {
          final currentState = state;
          if (currentState is _Loaded) {
            final updatedSettings = currentState.settings.copyWith(
              showGhost: enabled,
            );
            await _saveSettingsToStorage(updatedSettings);
            emit(SettingsState.loaded(updatedSettings));
          }
        },
        updateAutoRotate: (enabled) async {
          final currentState = state;
          if (currentState is _Loaded) {
            final updatedSettings = currentState.settings.copyWith(
              autoRotate: enabled,
            );
            await _saveSettingsToStorage(updatedSettings);
            emit(SettingsState.loaded(updatedSettings));
          }
        },
        updateDAS: (das) async {
          final currentState = state;
          if (currentState is _Loaded) {
            final updatedSettings = currentState.settings.copyWith(
              das: das,
            );
            await _saveSettingsToStorage(updatedSettings);
            emit(SettingsState.loaded(updatedSettings));
          }
        },
        updateARR: (arr) async {
          final currentState = state;
          if (currentState is _Loaded) {
            final updatedSettings = currentState.settings.copyWith(
              arr: arr,
            );
            await _saveSettingsToStorage(updatedSettings);
            emit(SettingsState.loaded(updatedSettings));
          }
        },
        resetSettings: () async {
          final defaultSettings = AppSettings.defaultSettings();
          await _saveSettingsToStorage(defaultSettings);
          emit(SettingsState.loaded(defaultSettings));
        },
      );
    });
  }

  Future<AppSettings> _loadSettingsFromStorage() async {
    try {
      final themeMode = await storageService.getString('theme_mode') ?? 'dark';
      final soundEnabled = await storageService.getBool('sound_enabled') ?? true;
      final musicEnabled = await storageService.getBool('music_enabled') ?? true;
      final vibrationEnabled = await storageService.getBool('vibration_enabled') ?? true;
      final showGhost = await storageService.getBool('show_ghost') ?? true;
      final autoRotate = await storageService.getBool('auto_rotate') ?? false;
      final das = await storageService.getInt('das') ?? 167;
      final arr = await storageService.getInt('arr') ?? 33;

      return AppSettings(
        themeMode: _parseThemeMode(themeMode),
        soundEnabled: soundEnabled,
        musicEnabled: musicEnabled,
        vibrationEnabled: vibrationEnabled,
        showGhost: showGhost,
        autoRotate: autoRotate,
        das: das,
        arr: arr,
      );
    } catch (e) {
      return AppSettings.defaultSettings();
    }
  }

  Future<void> _saveSettingsToStorage(AppSettings settings) async {
    await storageService.setString('theme_mode', _themeModeName(settings.themeMode));
    await storageService.setBool('sound_enabled', settings.soundEnabled);
    await storageService.setBool('music_enabled', settings.musicEnabled);
    await storageService.setBool('vibration_enabled', settings.vibrationEnabled);
    await storageService.setBool('show_ghost', settings.showGhost);
    await storageService.setBool('auto_rotate', settings.autoRotate);
    await storageService.setInt('das', settings.das);
    await storageService.setInt('arr', settings.arr);
  }

  ThemeMode _parseThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.dark;
    }
  }

  String _themeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

class AppSettings {
  final ThemeMode themeMode;
  final bool soundEnabled;
  final bool musicEnabled;
  final bool vibrationEnabled;
  final bool showGhost;
  final bool autoRotate;
  final int das; // Delayed Auto Shift (ms)
  final int arr; // Auto Repeat Rate (ms)

  const AppSettings({
    required this.themeMode,
    required this.soundEnabled,
    required this.musicEnabled,
    required this.vibrationEnabled,
    required this.showGhost,
    required this.autoRotate,
    required this.das,
    required this.arr,
  });

  static AppSettings defaultSettings() {
    return const AppSettings(
      themeMode: ThemeMode.dark,
      soundEnabled: true,
      musicEnabled: true,
      vibrationEnabled: true,
      showGhost: true,
      autoRotate: false,
      das: 167, // 10 frames at 60fps
      arr: 33,  // 2 frames at 60fps
    );
  }

  AppSettings copyWith({
    ThemeMode? themeMode,
    bool? soundEnabled,
    bool? musicEnabled,
    bool? vibrationEnabled,
    bool? showGhost,
    bool? autoRotate,
    int? das,
    int? arr,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      showGhost: showGhost ?? this.showGhost,
      autoRotate: autoRotate ?? this.autoRotate,
      das: das ?? this.das,
      arr: arr ?? this.arr,
    );
  }
}

// 임시 SettingsService 클래스 (main.dart에서 참조됨)
class SettingsService {
  static final SettingsService instance = SettingsService._internal();
  SettingsService._internal();

  Future<void> loadSettings() async {
    // 설정 로드 로직 (실제로는 SettingsBloc에서 처리)
  }
}
