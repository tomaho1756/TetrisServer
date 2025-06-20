// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsEvent _$SettingsEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'loadSettings':
      return _LoadSettings.fromJson(json);
    case 'updateThemeMode':
      return _UpdateThemeMode.fromJson(json);
    case 'updateSoundEnabled':
      return _UpdateSoundEnabled.fromJson(json);
    case 'updateMusicEnabled':
      return _UpdateMusicEnabled.fromJson(json);
    case 'updateVibrationEnabled':
      return _UpdateVibrationEnabled.fromJson(json);
    case 'updateShowGhost':
      return _UpdateShowGhost.fromJson(json);
    case 'updateAutoRotate':
      return _UpdateAutoRotate.fromJson(json);
    case 'updateDAS':
      return _UpdateDAS.fromJson(json);
    case 'updateARR':
      return _UpdateARR.fromJson(json);
    case 'resetSettings':
      return _ResetSettings.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SettingsEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SettingsEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEventCopyWith<$Res> {
  factory $SettingsEventCopyWith(
          SettingsEvent value, $Res Function(SettingsEvent) then) =
      _$SettingsEventCopyWithImpl<$Res, SettingsEvent>;
}

/// @nodoc
class _$SettingsEventCopyWithImpl<$Res, $Val extends SettingsEvent>
    implements $SettingsEventCopyWith<$Res> {
  _$SettingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSettingsImplCopyWith<$Res> {
  factory _$$LoadSettingsImplCopyWith(
          _$LoadSettingsImpl value, $Res Function(_$LoadSettingsImpl) then) =
      __$$LoadSettingsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSettingsImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$LoadSettingsImpl>
    implements _$$LoadSettingsImplCopyWith<$Res> {
  __$$LoadSettingsImplCopyWithImpl(
      _$LoadSettingsImpl _value, $Res Function(_$LoadSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$LoadSettingsImpl implements _LoadSettings {
  const _$LoadSettingsImpl({final String? $type})
      : $type = $type ?? 'loadSettings';

  factory _$LoadSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadSettingsImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.loadSettings()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSettingsImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return loadSettings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return loadSettings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (loadSettings != null) {
      return loadSettings();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return loadSettings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return loadSettings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (loadSettings != null) {
      return loadSettings(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadSettingsImplToJson(
      this,
    );
  }
}

abstract class _LoadSettings implements SettingsEvent {
  const factory _LoadSettings() = _$LoadSettingsImpl;

  factory _LoadSettings.fromJson(Map<String, dynamic> json) =
      _$LoadSettingsImpl.fromJson;
}

/// @nodoc
abstract class _$$UpdateThemeModeImplCopyWith<$Res> {
  factory _$$UpdateThemeModeImplCopyWith(_$UpdateThemeModeImpl value,
          $Res Function(_$UpdateThemeModeImpl) then) =
      __$$UpdateThemeModeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ThemeMode themeMode});
}

/// @nodoc
class __$$UpdateThemeModeImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateThemeModeImpl>
    implements _$$UpdateThemeModeImplCopyWith<$Res> {
  __$$UpdateThemeModeImplCopyWithImpl(
      _$UpdateThemeModeImpl _value, $Res Function(_$UpdateThemeModeImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
  }) {
    return _then(_$UpdateThemeModeImpl(
      null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateThemeModeImpl implements _UpdateThemeMode {
  const _$UpdateThemeModeImpl(this.themeMode, {final String? $type})
      : $type = $type ?? 'updateThemeMode';

  factory _$UpdateThemeModeImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateThemeModeImplFromJson(json);

  @override
  final ThemeMode themeMode;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.updateThemeMode(themeMode: $themeMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateThemeModeImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateThemeModeImplCopyWith<_$UpdateThemeModeImpl> get copyWith =>
      __$$UpdateThemeModeImplCopyWithImpl<_$UpdateThemeModeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return updateThemeMode(themeMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return updateThemeMode?.call(themeMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (updateThemeMode != null) {
      return updateThemeMode(themeMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return updateThemeMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return updateThemeMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (updateThemeMode != null) {
      return updateThemeMode(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateThemeModeImplToJson(
      this,
    );
  }
}

abstract class _UpdateThemeMode implements SettingsEvent {
  const factory _UpdateThemeMode(final ThemeMode themeMode) =
      _$UpdateThemeModeImpl;

  factory _UpdateThemeMode.fromJson(Map<String, dynamic> json) =
      _$UpdateThemeModeImpl.fromJson;

  ThemeMode get themeMode;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateThemeModeImplCopyWith<_$UpdateThemeModeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateSoundEnabledImplCopyWith<$Res> {
  factory _$$UpdateSoundEnabledImplCopyWith(_$UpdateSoundEnabledImpl value,
          $Res Function(_$UpdateSoundEnabledImpl) then) =
      __$$UpdateSoundEnabledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$UpdateSoundEnabledImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateSoundEnabledImpl>
    implements _$$UpdateSoundEnabledImplCopyWith<$Res> {
  __$$UpdateSoundEnabledImplCopyWithImpl(_$UpdateSoundEnabledImpl _value,
      $Res Function(_$UpdateSoundEnabledImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_$UpdateSoundEnabledImpl(
      null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateSoundEnabledImpl implements _UpdateSoundEnabled {
  const _$UpdateSoundEnabledImpl(this.enabled, {final String? $type})
      : $type = $type ?? 'updateSoundEnabled';

  factory _$UpdateSoundEnabledImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateSoundEnabledImplFromJson(json);

  @override
  final bool enabled;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.updateSoundEnabled(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSoundEnabledImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSoundEnabledImplCopyWith<_$UpdateSoundEnabledImpl> get copyWith =>
      __$$UpdateSoundEnabledImplCopyWithImpl<_$UpdateSoundEnabledImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return updateSoundEnabled(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return updateSoundEnabled?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (updateSoundEnabled != null) {
      return updateSoundEnabled(enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return updateSoundEnabled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return updateSoundEnabled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (updateSoundEnabled != null) {
      return updateSoundEnabled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateSoundEnabledImplToJson(
      this,
    );
  }
}

abstract class _UpdateSoundEnabled implements SettingsEvent {
  const factory _UpdateSoundEnabled(final bool enabled) =
      _$UpdateSoundEnabledImpl;

  factory _UpdateSoundEnabled.fromJson(Map<String, dynamic> json) =
      _$UpdateSoundEnabledImpl.fromJson;

  bool get enabled;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSoundEnabledImplCopyWith<_$UpdateSoundEnabledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateMusicEnabledImplCopyWith<$Res> {
  factory _$$UpdateMusicEnabledImplCopyWith(_$UpdateMusicEnabledImpl value,
          $Res Function(_$UpdateMusicEnabledImpl) then) =
      __$$UpdateMusicEnabledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$UpdateMusicEnabledImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateMusicEnabledImpl>
    implements _$$UpdateMusicEnabledImplCopyWith<$Res> {
  __$$UpdateMusicEnabledImplCopyWithImpl(_$UpdateMusicEnabledImpl _value,
      $Res Function(_$UpdateMusicEnabledImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_$UpdateMusicEnabledImpl(
      null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateMusicEnabledImpl implements _UpdateMusicEnabled {
  const _$UpdateMusicEnabledImpl(this.enabled, {final String? $type})
      : $type = $type ?? 'updateMusicEnabled';

  factory _$UpdateMusicEnabledImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateMusicEnabledImplFromJson(json);

  @override
  final bool enabled;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.updateMusicEnabled(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMusicEnabledImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMusicEnabledImplCopyWith<_$UpdateMusicEnabledImpl> get copyWith =>
      __$$UpdateMusicEnabledImplCopyWithImpl<_$UpdateMusicEnabledImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return updateMusicEnabled(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return updateMusicEnabled?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (updateMusicEnabled != null) {
      return updateMusicEnabled(enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return updateMusicEnabled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return updateMusicEnabled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (updateMusicEnabled != null) {
      return updateMusicEnabled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateMusicEnabledImplToJson(
      this,
    );
  }
}

abstract class _UpdateMusicEnabled implements SettingsEvent {
  const factory _UpdateMusicEnabled(final bool enabled) =
      _$UpdateMusicEnabledImpl;

  factory _UpdateMusicEnabled.fromJson(Map<String, dynamic> json) =
      _$UpdateMusicEnabledImpl.fromJson;

  bool get enabled;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMusicEnabledImplCopyWith<_$UpdateMusicEnabledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateVibrationEnabledImplCopyWith<$Res> {
  factory _$$UpdateVibrationEnabledImplCopyWith(
          _$UpdateVibrationEnabledImpl value,
          $Res Function(_$UpdateVibrationEnabledImpl) then) =
      __$$UpdateVibrationEnabledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$UpdateVibrationEnabledImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateVibrationEnabledImpl>
    implements _$$UpdateVibrationEnabledImplCopyWith<$Res> {
  __$$UpdateVibrationEnabledImplCopyWithImpl(
      _$UpdateVibrationEnabledImpl _value,
      $Res Function(_$UpdateVibrationEnabledImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_$UpdateVibrationEnabledImpl(
      null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateVibrationEnabledImpl implements _UpdateVibrationEnabled {
  const _$UpdateVibrationEnabledImpl(this.enabled, {final String? $type})
      : $type = $type ?? 'updateVibrationEnabled';

  factory _$UpdateVibrationEnabledImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateVibrationEnabledImplFromJson(json);

  @override
  final bool enabled;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.updateVibrationEnabled(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateVibrationEnabledImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateVibrationEnabledImplCopyWith<_$UpdateVibrationEnabledImpl>
      get copyWith => __$$UpdateVibrationEnabledImplCopyWithImpl<
          _$UpdateVibrationEnabledImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return updateVibrationEnabled(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return updateVibrationEnabled?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (updateVibrationEnabled != null) {
      return updateVibrationEnabled(enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return updateVibrationEnabled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return updateVibrationEnabled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (updateVibrationEnabled != null) {
      return updateVibrationEnabled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateVibrationEnabledImplToJson(
      this,
    );
  }
}

abstract class _UpdateVibrationEnabled implements SettingsEvent {
  const factory _UpdateVibrationEnabled(final bool enabled) =
      _$UpdateVibrationEnabledImpl;

  factory _UpdateVibrationEnabled.fromJson(Map<String, dynamic> json) =
      _$UpdateVibrationEnabledImpl.fromJson;

  bool get enabled;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateVibrationEnabledImplCopyWith<_$UpdateVibrationEnabledImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateShowGhostImplCopyWith<$Res> {
  factory _$$UpdateShowGhostImplCopyWith(_$UpdateShowGhostImpl value,
          $Res Function(_$UpdateShowGhostImpl) then) =
      __$$UpdateShowGhostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$UpdateShowGhostImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateShowGhostImpl>
    implements _$$UpdateShowGhostImplCopyWith<$Res> {
  __$$UpdateShowGhostImplCopyWithImpl(
      _$UpdateShowGhostImpl _value, $Res Function(_$UpdateShowGhostImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_$UpdateShowGhostImpl(
      null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateShowGhostImpl implements _UpdateShowGhost {
  const _$UpdateShowGhostImpl(this.enabled, {final String? $type})
      : $type = $type ?? 'updateShowGhost';

  factory _$UpdateShowGhostImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateShowGhostImplFromJson(json);

  @override
  final bool enabled;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.updateShowGhost(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateShowGhostImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateShowGhostImplCopyWith<_$UpdateShowGhostImpl> get copyWith =>
      __$$UpdateShowGhostImplCopyWithImpl<_$UpdateShowGhostImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return updateShowGhost(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return updateShowGhost?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (updateShowGhost != null) {
      return updateShowGhost(enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return updateShowGhost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return updateShowGhost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (updateShowGhost != null) {
      return updateShowGhost(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateShowGhostImplToJson(
      this,
    );
  }
}

abstract class _UpdateShowGhost implements SettingsEvent {
  const factory _UpdateShowGhost(final bool enabled) = _$UpdateShowGhostImpl;

  factory _UpdateShowGhost.fromJson(Map<String, dynamic> json) =
      _$UpdateShowGhostImpl.fromJson;

  bool get enabled;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateShowGhostImplCopyWith<_$UpdateShowGhostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateAutoRotateImplCopyWith<$Res> {
  factory _$$UpdateAutoRotateImplCopyWith(_$UpdateAutoRotateImpl value,
          $Res Function(_$UpdateAutoRotateImpl) then) =
      __$$UpdateAutoRotateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$UpdateAutoRotateImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateAutoRotateImpl>
    implements _$$UpdateAutoRotateImplCopyWith<$Res> {
  __$$UpdateAutoRotateImplCopyWithImpl(_$UpdateAutoRotateImpl _value,
      $Res Function(_$UpdateAutoRotateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_$UpdateAutoRotateImpl(
      null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateAutoRotateImpl implements _UpdateAutoRotate {
  const _$UpdateAutoRotateImpl(this.enabled, {final String? $type})
      : $type = $type ?? 'updateAutoRotate';

  factory _$UpdateAutoRotateImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateAutoRotateImplFromJson(json);

  @override
  final bool enabled;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.updateAutoRotate(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAutoRotateImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAutoRotateImplCopyWith<_$UpdateAutoRotateImpl> get copyWith =>
      __$$UpdateAutoRotateImplCopyWithImpl<_$UpdateAutoRotateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return updateAutoRotate(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return updateAutoRotate?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (updateAutoRotate != null) {
      return updateAutoRotate(enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return updateAutoRotate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return updateAutoRotate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (updateAutoRotate != null) {
      return updateAutoRotate(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateAutoRotateImplToJson(
      this,
    );
  }
}

abstract class _UpdateAutoRotate implements SettingsEvent {
  const factory _UpdateAutoRotate(final bool enabled) = _$UpdateAutoRotateImpl;

  factory _UpdateAutoRotate.fromJson(Map<String, dynamic> json) =
      _$UpdateAutoRotateImpl.fromJson;

  bool get enabled;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateAutoRotateImplCopyWith<_$UpdateAutoRotateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateDASImplCopyWith<$Res> {
  factory _$$UpdateDASImplCopyWith(
          _$UpdateDASImpl value, $Res Function(_$UpdateDASImpl) then) =
      __$$UpdateDASImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int das});
}

/// @nodoc
class __$$UpdateDASImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateDASImpl>
    implements _$$UpdateDASImplCopyWith<$Res> {
  __$$UpdateDASImplCopyWithImpl(
      _$UpdateDASImpl _value, $Res Function(_$UpdateDASImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? das = null,
  }) {
    return _then(_$UpdateDASImpl(
      null == das
          ? _value.das
          : das // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateDASImpl implements _UpdateDAS {
  const _$UpdateDASImpl(this.das, {final String? $type})
      : $type = $type ?? 'updateDAS';

  factory _$UpdateDASImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateDASImplFromJson(json);

  @override
  final int das;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.updateDAS(das: $das)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDASImpl &&
            (identical(other.das, das) || other.das == das));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, das);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDASImplCopyWith<_$UpdateDASImpl> get copyWith =>
      __$$UpdateDASImplCopyWithImpl<_$UpdateDASImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return updateDAS(das);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return updateDAS?.call(das);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (updateDAS != null) {
      return updateDAS(das);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return updateDAS(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return updateDAS?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (updateDAS != null) {
      return updateDAS(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateDASImplToJson(
      this,
    );
  }
}

abstract class _UpdateDAS implements SettingsEvent {
  const factory _UpdateDAS(final int das) = _$UpdateDASImpl;

  factory _UpdateDAS.fromJson(Map<String, dynamic> json) =
      _$UpdateDASImpl.fromJson;

  int get das;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDASImplCopyWith<_$UpdateDASImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateARRImplCopyWith<$Res> {
  factory _$$UpdateARRImplCopyWith(
          _$UpdateARRImpl value, $Res Function(_$UpdateARRImpl) then) =
      __$$UpdateARRImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int arr});
}

/// @nodoc
class __$$UpdateARRImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateARRImpl>
    implements _$$UpdateARRImplCopyWith<$Res> {
  __$$UpdateARRImplCopyWithImpl(
      _$UpdateARRImpl _value, $Res Function(_$UpdateARRImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arr = null,
  }) {
    return _then(_$UpdateARRImpl(
      null == arr
          ? _value.arr
          : arr // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateARRImpl implements _UpdateARR {
  const _$UpdateARRImpl(this.arr, {final String? $type})
      : $type = $type ?? 'updateARR';

  factory _$UpdateARRImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateARRImplFromJson(json);

  @override
  final int arr;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.updateARR(arr: $arr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateARRImpl &&
            (identical(other.arr, arr) || other.arr == arr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, arr);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateARRImplCopyWith<_$UpdateARRImpl> get copyWith =>
      __$$UpdateARRImplCopyWithImpl<_$UpdateARRImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return updateARR(arr);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return updateARR?.call(arr);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (updateARR != null) {
      return updateARR(arr);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return updateARR(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return updateARR?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (updateARR != null) {
      return updateARR(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateARRImplToJson(
      this,
    );
  }
}

abstract class _UpdateARR implements SettingsEvent {
  const factory _UpdateARR(final int arr) = _$UpdateARRImpl;

  factory _UpdateARR.fromJson(Map<String, dynamic> json) =
      _$UpdateARRImpl.fromJson;

  int get arr;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateARRImplCopyWith<_$UpdateARRImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetSettingsImplCopyWith<$Res> {
  factory _$$ResetSettingsImplCopyWith(
          _$ResetSettingsImpl value, $Res Function(_$ResetSettingsImpl) then) =
      __$$ResetSettingsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetSettingsImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$ResetSettingsImpl>
    implements _$$ResetSettingsImplCopyWith<$Res> {
  __$$ResetSettingsImplCopyWithImpl(
      _$ResetSettingsImpl _value, $Res Function(_$ResetSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ResetSettingsImpl implements _ResetSettings {
  const _$ResetSettingsImpl({final String? $type})
      : $type = $type ?? 'resetSettings';

  factory _$ResetSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetSettingsImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsEvent.resetSettings()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetSettingsImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSettings,
    required TResult Function(ThemeMode themeMode) updateThemeMode,
    required TResult Function(bool enabled) updateSoundEnabled,
    required TResult Function(bool enabled) updateMusicEnabled,
    required TResult Function(bool enabled) updateVibrationEnabled,
    required TResult Function(bool enabled) updateShowGhost,
    required TResult Function(bool enabled) updateAutoRotate,
    required TResult Function(int das) updateDAS,
    required TResult Function(int arr) updateARR,
    required TResult Function() resetSettings,
  }) {
    return resetSettings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSettings,
    TResult? Function(ThemeMode themeMode)? updateThemeMode,
    TResult? Function(bool enabled)? updateSoundEnabled,
    TResult? Function(bool enabled)? updateMusicEnabled,
    TResult? Function(bool enabled)? updateVibrationEnabled,
    TResult? Function(bool enabled)? updateShowGhost,
    TResult? Function(bool enabled)? updateAutoRotate,
    TResult? Function(int das)? updateDAS,
    TResult? Function(int arr)? updateARR,
    TResult? Function()? resetSettings,
  }) {
    return resetSettings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSettings,
    TResult Function(ThemeMode themeMode)? updateThemeMode,
    TResult Function(bool enabled)? updateSoundEnabled,
    TResult Function(bool enabled)? updateMusicEnabled,
    TResult Function(bool enabled)? updateVibrationEnabled,
    TResult Function(bool enabled)? updateShowGhost,
    TResult Function(bool enabled)? updateAutoRotate,
    TResult Function(int das)? updateDAS,
    TResult Function(int arr)? updateARR,
    TResult Function()? resetSettings,
    required TResult orElse(),
  }) {
    if (resetSettings != null) {
      return resetSettings();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSettings value) loadSettings,
    required TResult Function(_UpdateThemeMode value) updateThemeMode,
    required TResult Function(_UpdateSoundEnabled value) updateSoundEnabled,
    required TResult Function(_UpdateMusicEnabled value) updateMusicEnabled,
    required TResult Function(_UpdateVibrationEnabled value)
        updateVibrationEnabled,
    required TResult Function(_UpdateShowGhost value) updateShowGhost,
    required TResult Function(_UpdateAutoRotate value) updateAutoRotate,
    required TResult Function(_UpdateDAS value) updateDAS,
    required TResult Function(_UpdateARR value) updateARR,
    required TResult Function(_ResetSettings value) resetSettings,
  }) {
    return resetSettings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSettings value)? loadSettings,
    TResult? Function(_UpdateThemeMode value)? updateThemeMode,
    TResult? Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult? Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult? Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult? Function(_UpdateShowGhost value)? updateShowGhost,
    TResult? Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult? Function(_UpdateDAS value)? updateDAS,
    TResult? Function(_UpdateARR value)? updateARR,
    TResult? Function(_ResetSettings value)? resetSettings,
  }) {
    return resetSettings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSettings value)? loadSettings,
    TResult Function(_UpdateThemeMode value)? updateThemeMode,
    TResult Function(_UpdateSoundEnabled value)? updateSoundEnabled,
    TResult Function(_UpdateMusicEnabled value)? updateMusicEnabled,
    TResult Function(_UpdateVibrationEnabled value)? updateVibrationEnabled,
    TResult Function(_UpdateShowGhost value)? updateShowGhost,
    TResult Function(_UpdateAutoRotate value)? updateAutoRotate,
    TResult Function(_UpdateDAS value)? updateDAS,
    TResult Function(_UpdateARR value)? updateARR,
    TResult Function(_ResetSettings value)? resetSettings,
    required TResult orElse(),
  }) {
    if (resetSettings != null) {
      return resetSettings(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetSettingsImplToJson(
      this,
    );
  }
}

abstract class _ResetSettings implements SettingsEvent {
  const factory _ResetSettings() = _$ResetSettingsImpl;

  factory _ResetSettings.fromJson(Map<String, dynamic> json) =
      _$ResetSettingsImpl.fromJson;
}

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return _Initial.fromJson(json);
    case 'loaded':
      return _Loaded.fromJson(json);
    case 'error':
      return _Error.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SettingsState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SettingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppSettings settings) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppSettings settings)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppSettings settings)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SettingsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$InitialImpl implements _Initial {
  const _$InitialImpl({final String? $type}) : $type = $type ?? 'initial';

  factory _$InitialImpl.fromJson(Map<String, dynamic> json) =>
      _$$InitialImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppSettings settings) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppSettings settings)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppSettings settings)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InitialImplToJson(
      this,
    );
  }
}

abstract class _Initial implements SettingsState {
  const factory _Initial() = _$InitialImpl;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$InitialImpl.fromJson;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppSettings settings});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
  }) {
    return _then(_$LoadedImpl(
      null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.settings, {final String? $type})
      : $type = $type ?? 'loaded';

  factory _$LoadedImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadedImplFromJson(json);

  @override
  final AppSettings settings;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsState.loaded(settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, settings);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppSettings settings) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(settings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppSettings settings)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(settings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppSettings settings)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(settings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadedImplToJson(
      this,
    );
  }
}

abstract class _Loaded implements SettingsState {
  const factory _Loaded(final AppSettings settings) = _$LoadedImpl;

  factory _Loaded.fromJson(Map<String, dynamic> json) = _$LoadedImpl.fromJson;

  AppSettings get settings;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message, {final String? $type})
      : $type = $type ?? 'error';

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AppSettings settings) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AppSettings settings)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AppSettings settings)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(
      this,
    );
  }
}

abstract class _Error implements SettingsState {
  const factory _Error(final String message) = _$ErrorImpl;

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  String get message;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
