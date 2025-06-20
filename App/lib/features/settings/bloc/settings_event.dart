part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.loadSettings() = _LoadSettings;
  const factory SettingsEvent.updateThemeMode(ThemeMode themeMode) = _UpdateThemeMode;
  const factory SettingsEvent.updateSoundEnabled(bool enabled) = _UpdateSoundEnabled;
  const factory SettingsEvent.updateMusicEnabled(bool enabled) = _UpdateMusicEnabled;
  const factory SettingsEvent.updateVibrationEnabled(bool enabled) = _UpdateVibrationEnabled;
  const factory SettingsEvent.updateShowGhost(bool enabled) = _UpdateShowGhost;
  const factory SettingsEvent.updateAutoRotate(bool enabled) = _UpdateAutoRotate;
  const factory SettingsEvent.updateDAS(int das) = _UpdateDAS;
  const factory SettingsEvent.updateARR(int arr) = _UpdateARR;
  const factory SettingsEvent.resetSettings() = _ResetSettings;
}
