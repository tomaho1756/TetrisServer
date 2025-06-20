part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;
  const factory SettingsState.loaded(AppSettings settings) = _Loaded;
  const factory SettingsState.error(String message) = _Error;
}
