// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameEvent _$GameEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'startSingleGame':
      return _StartSingleGame.fromJson(json);
    case 'movePiece':
      return _MovePiece.fromJson(json);
    case 'rotatePiece':
      return _RotatePiece.fromJson(json);
    case 'dropPiece':
      return _DropPiece.fromJson(json);
    case 'holdPiece':
      return _HoldPiece.fromJson(json);
    case 'pauseGame':
      return _PauseGame.fromJson(json);
    case 'endGame':
      return _EndGame.fromJson(json);
    case 'restartGame':
      return _RestartGame.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'GameEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$GameEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this GameEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventCopyWith<$Res> {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) then) =
      _$GameEventCopyWithImpl<$Res, GameEvent>;
}

/// @nodoc
class _$GameEventCopyWithImpl<$Res, $Val extends GameEvent>
    implements $GameEventCopyWith<$Res> {
  _$GameEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartSingleGameImplCopyWith<$Res> {
  factory _$$StartSingleGameImplCopyWith(_$StartSingleGameImpl value,
          $Res Function(_$StartSingleGameImpl) then) =
      __$$StartSingleGameImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartSingleGameImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$StartSingleGameImpl>
    implements _$$StartSingleGameImplCopyWith<$Res> {
  __$$StartSingleGameImplCopyWithImpl(
      _$StartSingleGameImpl _value, $Res Function(_$StartSingleGameImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$StartSingleGameImpl implements _StartSingleGame {
  const _$StartSingleGameImpl({final String? $type})
      : $type = $type ?? 'startSingleGame';

  factory _$StartSingleGameImpl.fromJson(Map<String, dynamic> json) =>
      _$$StartSingleGameImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameEvent.startSingleGame()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartSingleGameImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) {
    return startSingleGame();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) {
    return startSingleGame?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) {
    if (startSingleGame != null) {
      return startSingleGame();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) {
    return startSingleGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) {
    return startSingleGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) {
    if (startSingleGame != null) {
      return startSingleGame(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StartSingleGameImplToJson(
      this,
    );
  }
}

abstract class _StartSingleGame implements GameEvent {
  const factory _StartSingleGame() = _$StartSingleGameImpl;

  factory _StartSingleGame.fromJson(Map<String, dynamic> json) =
      _$StartSingleGameImpl.fromJson;
}

/// @nodoc
abstract class _$$MovePieceImplCopyWith<$Res> {
  factory _$$MovePieceImplCopyWith(
          _$MovePieceImpl value, $Res Function(_$MovePieceImpl) then) =
      __$$MovePieceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String direction});
}

/// @nodoc
class __$$MovePieceImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$MovePieceImpl>
    implements _$$MovePieceImplCopyWith<$Res> {
  __$$MovePieceImplCopyWithImpl(
      _$MovePieceImpl _value, $Res Function(_$MovePieceImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
  }) {
    return _then(_$MovePieceImpl(
      null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovePieceImpl implements _MovePiece {
  const _$MovePieceImpl(this.direction, {final String? $type})
      : $type = $type ?? 'movePiece';

  factory _$MovePieceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovePieceImplFromJson(json);

  @override
  final String direction;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameEvent.movePiece(direction: $direction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovePieceImpl &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, direction);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovePieceImplCopyWith<_$MovePieceImpl> get copyWith =>
      __$$MovePieceImplCopyWithImpl<_$MovePieceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) {
    return movePiece(direction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) {
    return movePiece?.call(direction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) {
    if (movePiece != null) {
      return movePiece(direction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) {
    return movePiece(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) {
    return movePiece?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) {
    if (movePiece != null) {
      return movePiece(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MovePieceImplToJson(
      this,
    );
  }
}

abstract class _MovePiece implements GameEvent {
  const factory _MovePiece(final String direction) = _$MovePieceImpl;

  factory _MovePiece.fromJson(Map<String, dynamic> json) =
      _$MovePieceImpl.fromJson;

  String get direction;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovePieceImplCopyWith<_$MovePieceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RotatePieceImplCopyWith<$Res> {
  factory _$$RotatePieceImplCopyWith(
          _$RotatePieceImpl value, $Res Function(_$RotatePieceImpl) then) =
      __$$RotatePieceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool clockwise});
}

/// @nodoc
class __$$RotatePieceImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$RotatePieceImpl>
    implements _$$RotatePieceImplCopyWith<$Res> {
  __$$RotatePieceImplCopyWithImpl(
      _$RotatePieceImpl _value, $Res Function(_$RotatePieceImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clockwise = null,
  }) {
    return _then(_$RotatePieceImpl(
      null == clockwise
          ? _value.clockwise
          : clockwise // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RotatePieceImpl implements _RotatePiece {
  const _$RotatePieceImpl(this.clockwise, {final String? $type})
      : $type = $type ?? 'rotatePiece';

  factory _$RotatePieceImpl.fromJson(Map<String, dynamic> json) =>
      _$$RotatePieceImplFromJson(json);

  @override
  final bool clockwise;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameEvent.rotatePiece(clockwise: $clockwise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RotatePieceImpl &&
            (identical(other.clockwise, clockwise) ||
                other.clockwise == clockwise));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, clockwise);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RotatePieceImplCopyWith<_$RotatePieceImpl> get copyWith =>
      __$$RotatePieceImplCopyWithImpl<_$RotatePieceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) {
    return rotatePiece(clockwise);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) {
    return rotatePiece?.call(clockwise);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) {
    if (rotatePiece != null) {
      return rotatePiece(clockwise);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) {
    return rotatePiece(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) {
    return rotatePiece?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) {
    if (rotatePiece != null) {
      return rotatePiece(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RotatePieceImplToJson(
      this,
    );
  }
}

abstract class _RotatePiece implements GameEvent {
  const factory _RotatePiece(final bool clockwise) = _$RotatePieceImpl;

  factory _RotatePiece.fromJson(Map<String, dynamic> json) =
      _$RotatePieceImpl.fromJson;

  bool get clockwise;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RotatePieceImplCopyWith<_$RotatePieceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DropPieceImplCopyWith<$Res> {
  factory _$$DropPieceImplCopyWith(
          _$DropPieceImpl value, $Res Function(_$DropPieceImpl) then) =
      __$$DropPieceImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DropPieceImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$DropPieceImpl>
    implements _$$DropPieceImplCopyWith<$Res> {
  __$$DropPieceImplCopyWithImpl(
      _$DropPieceImpl _value, $Res Function(_$DropPieceImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DropPieceImpl implements _DropPiece {
  const _$DropPieceImpl({final String? $type}) : $type = $type ?? 'dropPiece';

  factory _$DropPieceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropPieceImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameEvent.dropPiece()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DropPieceImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) {
    return dropPiece();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) {
    return dropPiece?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) {
    if (dropPiece != null) {
      return dropPiece();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) {
    return dropPiece(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) {
    return dropPiece?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) {
    if (dropPiece != null) {
      return dropPiece(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DropPieceImplToJson(
      this,
    );
  }
}

abstract class _DropPiece implements GameEvent {
  const factory _DropPiece() = _$DropPieceImpl;

  factory _DropPiece.fromJson(Map<String, dynamic> json) =
      _$DropPieceImpl.fromJson;
}

/// @nodoc
abstract class _$$HoldPieceImplCopyWith<$Res> {
  factory _$$HoldPieceImplCopyWith(
          _$HoldPieceImpl value, $Res Function(_$HoldPieceImpl) then) =
      __$$HoldPieceImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HoldPieceImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$HoldPieceImpl>
    implements _$$HoldPieceImplCopyWith<$Res> {
  __$$HoldPieceImplCopyWithImpl(
      _$HoldPieceImpl _value, $Res Function(_$HoldPieceImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$HoldPieceImpl implements _HoldPiece {
  const _$HoldPieceImpl({final String? $type}) : $type = $type ?? 'holdPiece';

  factory _$HoldPieceImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldPieceImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameEvent.holdPiece()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HoldPieceImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) {
    return holdPiece();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) {
    return holdPiece?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) {
    if (holdPiece != null) {
      return holdPiece();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) {
    return holdPiece(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) {
    return holdPiece?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) {
    if (holdPiece != null) {
      return holdPiece(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldPieceImplToJson(
      this,
    );
  }
}

abstract class _HoldPiece implements GameEvent {
  const factory _HoldPiece() = _$HoldPieceImpl;

  factory _HoldPiece.fromJson(Map<String, dynamic> json) =
      _$HoldPieceImpl.fromJson;
}

/// @nodoc
abstract class _$$PauseGameImplCopyWith<$Res> {
  factory _$$PauseGameImplCopyWith(
          _$PauseGameImpl value, $Res Function(_$PauseGameImpl) then) =
      __$$PauseGameImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PauseGameImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$PauseGameImpl>
    implements _$$PauseGameImplCopyWith<$Res> {
  __$$PauseGameImplCopyWithImpl(
      _$PauseGameImpl _value, $Res Function(_$PauseGameImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$PauseGameImpl implements _PauseGame {
  const _$PauseGameImpl({final String? $type}) : $type = $type ?? 'pauseGame';

  factory _$PauseGameImpl.fromJson(Map<String, dynamic> json) =>
      _$$PauseGameImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameEvent.pauseGame()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PauseGameImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) {
    return pauseGame();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) {
    return pauseGame?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) {
    if (pauseGame != null) {
      return pauseGame();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) {
    return pauseGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) {
    return pauseGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) {
    if (pauseGame != null) {
      return pauseGame(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PauseGameImplToJson(
      this,
    );
  }
}

abstract class _PauseGame implements GameEvent {
  const factory _PauseGame() = _$PauseGameImpl;

  factory _PauseGame.fromJson(Map<String, dynamic> json) =
      _$PauseGameImpl.fromJson;
}

/// @nodoc
abstract class _$$EndGameImplCopyWith<$Res> {
  factory _$$EndGameImplCopyWith(
          _$EndGameImpl value, $Res Function(_$EndGameImpl) then) =
      __$$EndGameImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EndGameImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$EndGameImpl>
    implements _$$EndGameImplCopyWith<$Res> {
  __$$EndGameImplCopyWithImpl(
      _$EndGameImpl _value, $Res Function(_$EndGameImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$EndGameImpl implements _EndGame {
  const _$EndGameImpl({final String? $type}) : $type = $type ?? 'endGame';

  factory _$EndGameImpl.fromJson(Map<String, dynamic> json) =>
      _$$EndGameImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameEvent.endGame()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EndGameImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) {
    return endGame();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) {
    return endGame?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) {
    if (endGame != null) {
      return endGame();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) {
    return endGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) {
    return endGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) {
    if (endGame != null) {
      return endGame(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EndGameImplToJson(
      this,
    );
  }
}

abstract class _EndGame implements GameEvent {
  const factory _EndGame() = _$EndGameImpl;

  factory _EndGame.fromJson(Map<String, dynamic> json) = _$EndGameImpl.fromJson;
}

/// @nodoc
abstract class _$$RestartGameImplCopyWith<$Res> {
  factory _$$RestartGameImplCopyWith(
          _$RestartGameImpl value, $Res Function(_$RestartGameImpl) then) =
      __$$RestartGameImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RestartGameImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$RestartGameImpl>
    implements _$$RestartGameImplCopyWith<$Res> {
  __$$RestartGameImplCopyWithImpl(
      _$RestartGameImpl _value, $Res Function(_$RestartGameImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$RestartGameImpl implements _RestartGame {
  const _$RestartGameImpl({final String? $type})
      : $type = $type ?? 'restartGame';

  factory _$RestartGameImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestartGameImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameEvent.restartGame()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RestartGameImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() startSingleGame,
    required TResult Function(String direction) movePiece,
    required TResult Function(bool clockwise) rotatePiece,
    required TResult Function() dropPiece,
    required TResult Function() holdPiece,
    required TResult Function() pauseGame,
    required TResult Function() endGame,
    required TResult Function() restartGame,
  }) {
    return restartGame();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? startSingleGame,
    TResult? Function(String direction)? movePiece,
    TResult? Function(bool clockwise)? rotatePiece,
    TResult? Function()? dropPiece,
    TResult? Function()? holdPiece,
    TResult? Function()? pauseGame,
    TResult? Function()? endGame,
    TResult? Function()? restartGame,
  }) {
    return restartGame?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? startSingleGame,
    TResult Function(String direction)? movePiece,
    TResult Function(bool clockwise)? rotatePiece,
    TResult Function()? dropPiece,
    TResult Function()? holdPiece,
    TResult Function()? pauseGame,
    TResult Function()? endGame,
    TResult Function()? restartGame,
    required TResult orElse(),
  }) {
    if (restartGame != null) {
      return restartGame();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StartSingleGame value) startSingleGame,
    required TResult Function(_MovePiece value) movePiece,
    required TResult Function(_RotatePiece value) rotatePiece,
    required TResult Function(_DropPiece value) dropPiece,
    required TResult Function(_HoldPiece value) holdPiece,
    required TResult Function(_PauseGame value) pauseGame,
    required TResult Function(_EndGame value) endGame,
    required TResult Function(_RestartGame value) restartGame,
  }) {
    return restartGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StartSingleGame value)? startSingleGame,
    TResult? Function(_MovePiece value)? movePiece,
    TResult? Function(_RotatePiece value)? rotatePiece,
    TResult? Function(_DropPiece value)? dropPiece,
    TResult? Function(_HoldPiece value)? holdPiece,
    TResult? Function(_PauseGame value)? pauseGame,
    TResult? Function(_EndGame value)? endGame,
    TResult? Function(_RestartGame value)? restartGame,
  }) {
    return restartGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StartSingleGame value)? startSingleGame,
    TResult Function(_MovePiece value)? movePiece,
    TResult Function(_RotatePiece value)? rotatePiece,
    TResult Function(_DropPiece value)? dropPiece,
    TResult Function(_HoldPiece value)? holdPiece,
    TResult Function(_PauseGame value)? pauseGame,
    TResult Function(_EndGame value)? endGame,
    TResult Function(_RestartGame value)? restartGame,
    required TResult orElse(),
  }) {
    if (restartGame != null) {
      return restartGame(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RestartGameImplToJson(
      this,
    );
  }
}

abstract class _RestartGame implements GameEvent {
  const factory _RestartGame() = _$RestartGameImpl;

  factory _RestartGame.fromJson(Map<String, dynamic> json) =
      _$RestartGameImpl.fromJson;
}

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return _Initial.fromJson(json);
    case 'loading':
      return _Loading.fromJson(json);
    case 'playing':
      return _Playing.fromJson(json);
    case 'gameOver':
      return _GameOver.fromJson(json);
    case 'error':
      return _Error.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'GameState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$GameState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)
        playing,
    required TResult Function(int finalScore, int level, int lines) gameOver,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult? Function(int finalScore, int level, int lines)? gameOver,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult Function(int finalScore, int level, int lines)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
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
    extends _$GameStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
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
    return 'GameState.initial()';
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
    required TResult Function() loading,
    required TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)
        playing,
    required TResult Function(int finalScore, int level, int lines) gameOver,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult? Function(int finalScore, int level, int lines)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult Function(int finalScore, int level, int lines)? gameOver,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
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

abstract class _Initial implements GameState {
  const factory _Initial() = _$InitialImpl;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$InitialImpl.fromJson;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({final String? $type}) : $type = $type ?? 'loading';

  factory _$LoadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadingImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)
        playing,
    required TResult Function(int finalScore, int level, int lines) gameOver,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult? Function(int finalScore, int level, int lines)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult Function(int finalScore, int level, int lines)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadingImplToJson(
      this,
    );
  }
}

abstract class _Loading implements GameState {
  const factory _Loading() = _$LoadingImpl;

  factory _Loading.fromJson(Map<String, dynamic> json) = _$LoadingImpl.fromJson;
}

/// @nodoc
abstract class _$$PlayingImplCopyWith<$Res> {
  factory _$$PlayingImplCopyWith(
          _$PlayingImpl value, $Res Function(_$PlayingImpl) then) =
      __$$PlayingImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String gameId,
      GameBoard board,
      Tetromino? currentPiece,
      List<Tetromino> nextPieces,
      Tetromino? heldPiece,
      int score,
      int level,
      int lines,
      bool isGameOver,
      bool isPaused});

  $GameBoardCopyWith<$Res> get board;
  $TetrominoCopyWith<$Res>? get currentPiece;
  $TetrominoCopyWith<$Res>? get heldPiece;
}

/// @nodoc
class __$$PlayingImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$PlayingImpl>
    implements _$$PlayingImplCopyWith<$Res> {
  __$$PlayingImplCopyWithImpl(
      _$PlayingImpl _value, $Res Function(_$PlayingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? board = null,
    Object? currentPiece = freezed,
    Object? nextPieces = null,
    Object? heldPiece = freezed,
    Object? score = null,
    Object? level = null,
    Object? lines = null,
    Object? isGameOver = null,
    Object? isPaused = null,
  }) {
    return _then(_$PlayingImpl(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      board: null == board
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as GameBoard,
      currentPiece: freezed == currentPiece
          ? _value.currentPiece
          : currentPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      nextPieces: null == nextPieces
          ? _value._nextPieces
          : nextPieces // ignore: cast_nullable_to_non_nullable
              as List<Tetromino>,
      heldPiece: freezed == heldPiece
          ? _value.heldPiece
          : heldPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      lines: null == lines
          ? _value.lines
          : lines // ignore: cast_nullable_to_non_nullable
              as int,
      isGameOver: null == isGameOver
          ? _value.isGameOver
          : isGameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameBoardCopyWith<$Res> get board {
    return $GameBoardCopyWith<$Res>(_value.board, (value) {
      return _then(_value.copyWith(board: value));
    });
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TetrominoCopyWith<$Res>? get currentPiece {
    if (_value.currentPiece == null) {
      return null;
    }

    return $TetrominoCopyWith<$Res>(_value.currentPiece!, (value) {
      return _then(_value.copyWith(currentPiece: value));
    });
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TetrominoCopyWith<$Res>? get heldPiece {
    if (_value.heldPiece == null) {
      return null;
    }

    return $TetrominoCopyWith<$Res>(_value.heldPiece!, (value) {
      return _then(_value.copyWith(heldPiece: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayingImpl implements _Playing {
  const _$PlayingImpl(
      {required this.gameId,
      required this.board,
      required this.currentPiece,
      required final List<Tetromino> nextPieces,
      required this.heldPiece,
      required this.score,
      required this.level,
      required this.lines,
      required this.isGameOver,
      required this.isPaused,
      final String? $type})
      : _nextPieces = nextPieces,
        $type = $type ?? 'playing';

  factory _$PlayingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayingImplFromJson(json);

  @override
  final String gameId;
  @override
  final GameBoard board;
  @override
  final Tetromino? currentPiece;
  final List<Tetromino> _nextPieces;
  @override
  List<Tetromino> get nextPieces {
    if (_nextPieces is EqualUnmodifiableListView) return _nextPieces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nextPieces);
  }

  @override
  final Tetromino? heldPiece;
  @override
  final int score;
  @override
  final int level;
  @override
  final int lines;
  @override
  final bool isGameOver;
  @override
  final bool isPaused;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameState.playing(gameId: $gameId, board: $board, currentPiece: $currentPiece, nextPieces: $nextPieces, heldPiece: $heldPiece, score: $score, level: $level, lines: $lines, isGameOver: $isGameOver, isPaused: $isPaused)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayingImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.board, board) || other.board == board) &&
            (identical(other.currentPiece, currentPiece) ||
                other.currentPiece == currentPiece) &&
            const DeepCollectionEquality()
                .equals(other._nextPieces, _nextPieces) &&
            (identical(other.heldPiece, heldPiece) ||
                other.heldPiece == heldPiece) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.lines, lines) || other.lines == lines) &&
            (identical(other.isGameOver, isGameOver) ||
                other.isGameOver == isGameOver) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      gameId,
      board,
      currentPiece,
      const DeepCollectionEquality().hash(_nextPieces),
      heldPiece,
      score,
      level,
      lines,
      isGameOver,
      isPaused);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayingImplCopyWith<_$PlayingImpl> get copyWith =>
      __$$PlayingImplCopyWithImpl<_$PlayingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)
        playing,
    required TResult Function(int finalScore, int level, int lines) gameOver,
    required TResult Function(String message) error,
  }) {
    return playing(gameId, board, currentPiece, nextPieces, heldPiece, score,
        level, lines, isGameOver, isPaused);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult? Function(int finalScore, int level, int lines)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return playing?.call(gameId, board, currentPiece, nextPieces, heldPiece,
        score, level, lines, isGameOver, isPaused);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult Function(int finalScore, int level, int lines)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(gameId, board, currentPiece, nextPieces, heldPiece, score,
          level, lines, isGameOver, isPaused);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return playing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayingImplToJson(
      this,
    );
  }
}

abstract class _Playing implements GameState {
  const factory _Playing(
      {required final String gameId,
      required final GameBoard board,
      required final Tetromino? currentPiece,
      required final List<Tetromino> nextPieces,
      required final Tetromino? heldPiece,
      required final int score,
      required final int level,
      required final int lines,
      required final bool isGameOver,
      required final bool isPaused}) = _$PlayingImpl;

  factory _Playing.fromJson(Map<String, dynamic> json) = _$PlayingImpl.fromJson;

  String get gameId;
  GameBoard get board;
  Tetromino? get currentPiece;
  List<Tetromino> get nextPieces;
  Tetromino? get heldPiece;
  int get score;
  int get level;
  int get lines;
  bool get isGameOver;
  bool get isPaused;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayingImplCopyWith<_$PlayingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameOverImplCopyWith<$Res> {
  factory _$$GameOverImplCopyWith(
          _$GameOverImpl value, $Res Function(_$GameOverImpl) then) =
      __$$GameOverImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int finalScore, int level, int lines});
}

/// @nodoc
class __$$GameOverImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameOverImpl>
    implements _$$GameOverImplCopyWith<$Res> {
  __$$GameOverImplCopyWithImpl(
      _$GameOverImpl _value, $Res Function(_$GameOverImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? finalScore = null,
    Object? level = null,
    Object? lines = null,
  }) {
    return _then(_$GameOverImpl(
      finalScore: null == finalScore
          ? _value.finalScore
          : finalScore // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      lines: null == lines
          ? _value.lines
          : lines // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameOverImpl implements _GameOver {
  const _$GameOverImpl(
      {required this.finalScore,
      required this.level,
      required this.lines,
      final String? $type})
      : $type = $type ?? 'gameOver';

  factory _$GameOverImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameOverImplFromJson(json);

  @override
  final int finalScore;
  @override
  final int level;
  @override
  final int lines;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'GameState.gameOver(finalScore: $finalScore, level: $level, lines: $lines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameOverImpl &&
            (identical(other.finalScore, finalScore) ||
                other.finalScore == finalScore) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.lines, lines) || other.lines == lines));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, finalScore, level, lines);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameOverImplCopyWith<_$GameOverImpl> get copyWith =>
      __$$GameOverImplCopyWithImpl<_$GameOverImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)
        playing,
    required TResult Function(int finalScore, int level, int lines) gameOver,
    required TResult Function(String message) error,
  }) {
    return gameOver(finalScore, level, lines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult? Function(int finalScore, int level, int lines)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return gameOver?.call(finalScore, level, lines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult Function(int finalScore, int level, int lines)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (gameOver != null) {
      return gameOver(finalScore, level, lines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return gameOver(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return gameOver?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (gameOver != null) {
      return gameOver(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GameOverImplToJson(
      this,
    );
  }
}

abstract class _GameOver implements GameState {
  const factory _GameOver(
      {required final int finalScore,
      required final int level,
      required final int lines}) = _$GameOverImpl;

  factory _GameOver.fromJson(Map<String, dynamic> json) =
      _$GameOverImpl.fromJson;

  int get finalScore;
  int get level;
  int get lines;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameOverImplCopyWith<_$GameOverImpl> get copyWith =>
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
    extends _$GameStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
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
    return 'GameState.error(message: $message)';
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

  /// Create a copy of GameState
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
    required TResult Function() loading,
    required TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)
        playing,
    required TResult Function(int finalScore, int level, int lines) gameOver,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult? Function(int finalScore, int level, int lines)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String gameId,
            GameBoard board,
            Tetromino? currentPiece,
            List<Tetromino> nextPieces,
            Tetromino? heldPiece,
            int score,
            int level,
            int lines,
            bool isGameOver,
            bool isPaused)?
        playing,
    TResult Function(int finalScore, int level, int lines)? gameOver,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
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

abstract class _Error implements GameState {
  const factory _Error(final String message) = _$ErrorImpl;

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  String get message;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
