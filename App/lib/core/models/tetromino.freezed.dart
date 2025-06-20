// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tetromino.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tetromino _$TetrominoFromJson(Map<String, dynamic> json) {
  return _Tetromino.fromJson(json);
}

/// @nodoc
mixin _$Tetromino {
  TetrominoType get type => throw _privateConstructorUsedError;
  List<List<bool>> get shape => throw _privateConstructorUsedError;
  Position get position => throw _privateConstructorUsedError;
  int get rotation => throw _privateConstructorUsedError;
  bool get isLocked => throw _privateConstructorUsedError;
  bool get isGhost => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(TetrominoType type, List<List<bool>> shape,
            Position position, int rotation, bool isLocked, bool isGhost)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(TetrominoType type, List<List<bool>> shape,
            Position position, int rotation, bool isLocked, bool isGhost)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(TetrominoType type, List<List<bool>> shape,
            Position position, int rotation, bool isLocked, bool isGhost)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Tetromino value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Tetromino value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Tetromino value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Tetromino to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tetromino
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TetrominoCopyWith<Tetromino> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TetrominoCopyWith<$Res> {
  factory $TetrominoCopyWith(Tetromino value, $Res Function(Tetromino) then) =
      _$TetrominoCopyWithImpl<$Res, Tetromino>;
  @useResult
  $Res call(
      {TetrominoType type,
      List<List<bool>> shape,
      Position position,
      int rotation,
      bool isLocked,
      bool isGhost});

  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class _$TetrominoCopyWithImpl<$Res, $Val extends Tetromino>
    implements $TetrominoCopyWith<$Res> {
  _$TetrominoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tetromino
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? shape = null,
    Object? position = null,
    Object? rotation = null,
    Object? isLocked = null,
    Object? isGhost = null,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TetrominoType,
      shape: null == shape
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as List<List<bool>>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as int,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      isGhost: null == isGhost
          ? _value.isGhost
          : isGhost // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of Tetromino
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PositionCopyWith<$Res> get position {
    return $PositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TetrominoImplCopyWith<$Res>
    implements $TetrominoCopyWith<$Res> {
  factory _$$TetrominoImplCopyWith(
          _$TetrominoImpl value, $Res Function(_$TetrominoImpl) then) =
      __$$TetrominoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TetrominoType type,
      List<List<bool>> shape,
      Position position,
      int rotation,
      bool isLocked,
      bool isGhost});

  @override
  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$TetrominoImplCopyWithImpl<$Res>
    extends _$TetrominoCopyWithImpl<$Res, _$TetrominoImpl>
    implements _$$TetrominoImplCopyWith<$Res> {
  __$$TetrominoImplCopyWithImpl(
      _$TetrominoImpl _value, $Res Function(_$TetrominoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tetromino
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? shape = null,
    Object? position = null,
    Object? rotation = null,
    Object? isLocked = null,
    Object? isGhost = null,
  }) {
    return _then(_$TetrominoImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TetrominoType,
      shape: null == shape
          ? _value._shape
          : shape // ignore: cast_nullable_to_non_nullable
              as List<List<bool>>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      rotation: null == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as int,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      isGhost: null == isGhost
          ? _value.isGhost
          : isGhost // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TetrominoImpl implements _Tetromino {
  const _$TetrominoImpl(
      {required this.type,
      required final List<List<bool>> shape,
      required this.position,
      this.rotation = 0,
      this.isLocked = false,
      this.isGhost = false})
      : _shape = shape;

  factory _$TetrominoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TetrominoImplFromJson(json);

  @override
  final TetrominoType type;
  final List<List<bool>> _shape;
  @override
  List<List<bool>> get shape {
    if (_shape is EqualUnmodifiableListView) return _shape;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shape);
  }

  @override
  final Position position;
  @override
  @JsonKey()
  final int rotation;
  @override
  @JsonKey()
  final bool isLocked;
  @override
  @JsonKey()
  final bool isGhost;

  @override
  String toString() {
    return 'Tetromino(type: $type, shape: $shape, position: $position, rotation: $rotation, isLocked: $isLocked, isGhost: $isGhost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TetrominoImpl &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other._shape, _shape) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.rotation, rotation) ||
                other.rotation == rotation) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.isGhost, isGhost) || other.isGhost == isGhost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(_shape),
      position,
      rotation,
      isLocked,
      isGhost);

  /// Create a copy of Tetromino
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TetrominoImplCopyWith<_$TetrominoImpl> get copyWith =>
      __$$TetrominoImplCopyWithImpl<_$TetrominoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(TetrominoType type, List<List<bool>> shape,
            Position position, int rotation, bool isLocked, bool isGhost)
        $default,
  ) {
    return $default(type, shape, position, rotation, isLocked, isGhost);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(TetrominoType type, List<List<bool>> shape,
            Position position, int rotation, bool isLocked, bool isGhost)?
        $default,
  ) {
    return $default?.call(type, shape, position, rotation, isLocked, isGhost);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(TetrominoType type, List<List<bool>> shape,
            Position position, int rotation, bool isLocked, bool isGhost)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(type, shape, position, rotation, isLocked, isGhost);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Tetromino value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Tetromino value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Tetromino value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TetrominoImplToJson(
      this,
    );
  }
}

abstract class _Tetromino implements Tetromino {
  const factory _Tetromino(
      {required final TetrominoType type,
      required final List<List<bool>> shape,
      required final Position position,
      final int rotation,
      final bool isLocked,
      final bool isGhost}) = _$TetrominoImpl;

  factory _Tetromino.fromJson(Map<String, dynamic> json) =
      _$TetrominoImpl.fromJson;

  @override
  TetrominoType get type;
  @override
  List<List<bool>> get shape;
  @override
  Position get position;
  @override
  int get rotation;
  @override
  bool get isLocked;
  @override
  bool get isGhost;

  /// Create a copy of Tetromino
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TetrominoImplCopyWith<_$TetrominoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Position _$PositionFromJson(Map<String, dynamic> json) {
  return _Position.fromJson(json);
}

/// @nodoc
mixin _$Position {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int x, int y) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int x, int y)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int x, int y)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Position value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Position value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Position value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Position to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PositionCopyWith<Position> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionCopyWith<$Res> {
  factory $PositionCopyWith(Position value, $Res Function(Position) then) =
      _$PositionCopyWithImpl<$Res, Position>;
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class _$PositionCopyWithImpl<$Res, $Val extends Position>
    implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PositionImplCopyWith<$Res>
    implements $PositionCopyWith<$Res> {
  factory _$$PositionImplCopyWith(
          _$PositionImpl value, $Res Function(_$PositionImpl) then) =
      __$$PositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class __$$PositionImplCopyWithImpl<$Res>
    extends _$PositionCopyWithImpl<$Res, _$PositionImpl>
    implements _$$PositionImplCopyWith<$Res> {
  __$$PositionImplCopyWithImpl(
      _$PositionImpl _value, $Res Function(_$PositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$PositionImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PositionImpl implements _Position {
  const _$PositionImpl({required this.x, required this.y});

  factory _$PositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PositionImplFromJson(json);

  @override
  final int x;
  @override
  final int y;

  @override
  String toString() {
    return 'Position(x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      __$$PositionImplCopyWithImpl<_$PositionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int x, int y) $default,
  ) {
    return $default(x, y);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int x, int y)? $default,
  ) {
    return $default?.call(x, y);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int x, int y)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(x, y);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Position value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Position value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Position value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PositionImplToJson(
      this,
    );
  }
}

abstract class _Position implements Position {
  const factory _Position({required final int x, required final int y}) =
      _$PositionImpl;

  factory _Position.fromJson(Map<String, dynamic> json) =
      _$PositionImpl.fromJson;

  @override
  int get x;
  @override
  int get y;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TetrominoQueue _$TetrominoQueueFromJson(Map<String, dynamic> json) {
  return _TetrominoQueue.fromJson(json);
}

/// @nodoc
mixin _$TetrominoQueue {
  List<AppConstants.TetrominoType> get upcoming =>
      throw _privateConstructorUsedError;
  List<AppConstants.TetrominoType> get bag =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<AppConstants.TetrominoType> upcoming,
            List<AppConstants.TetrominoType> bag)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<AppConstants.TetrominoType> upcoming,
            List<AppConstants.TetrominoType> bag)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<AppConstants.TetrominoType> upcoming,
            List<AppConstants.TetrominoType> bag)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TetrominoQueue value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TetrominoQueue value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TetrominoQueue value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this TetrominoQueue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TetrominoQueue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TetrominoQueueCopyWith<TetrominoQueue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TetrominoQueueCopyWith<$Res> {
  factory $TetrominoQueueCopyWith(
          TetrominoQueue value, $Res Function(TetrominoQueue) then) =
      _$TetrominoQueueCopyWithImpl<$Res, TetrominoQueue>;
  @useResult
  $Res call(
      {List<AppConstants.TetrominoType> upcoming,
      List<AppConstants.TetrominoType> bag});
}

/// @nodoc
class _$TetrominoQueueCopyWithImpl<$Res, $Val extends TetrominoQueue>
    implements $TetrominoQueueCopyWith<$Res> {
  _$TetrominoQueueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TetrominoQueue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? bag = null,
  }) {
    return _then(_value.copyWith(
      upcoming: null == upcoming
          ? _value.upcoming
          : upcoming // ignore: cast_nullable_to_non_nullable
              as List<AppConstants.TetrominoType>,
      bag: null == bag
          ? _value.bag
          : bag // ignore: cast_nullable_to_non_nullable
              as List<AppConstants.TetrominoType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TetrominoQueueImplCopyWith<$Res>
    implements $TetrominoQueueCopyWith<$Res> {
  factory _$$TetrominoQueueImplCopyWith(_$TetrominoQueueImpl value,
          $Res Function(_$TetrominoQueueImpl) then) =
      __$$TetrominoQueueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AppConstants.TetrominoType> upcoming,
      List<AppConstants.TetrominoType> bag});
}

/// @nodoc
class __$$TetrominoQueueImplCopyWithImpl<$Res>
    extends _$TetrominoQueueCopyWithImpl<$Res, _$TetrominoQueueImpl>
    implements _$$TetrominoQueueImplCopyWith<$Res> {
  __$$TetrominoQueueImplCopyWithImpl(
      _$TetrominoQueueImpl _value, $Res Function(_$TetrominoQueueImpl) _then)
      : super(_value, _then);

  /// Create a copy of TetrominoQueue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? bag = null,
  }) {
    return _then(_$TetrominoQueueImpl(
      upcoming: null == upcoming
          ? _value._upcoming
          : upcoming // ignore: cast_nullable_to_non_nullable
              as List<AppConstants.TetrominoType>,
      bag: null == bag
          ? _value._bag
          : bag // ignore: cast_nullable_to_non_nullable
              as List<AppConstants.TetrominoType>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TetrominoQueueImpl implements _TetrominoQueue {
  const _$TetrominoQueueImpl(
      {final List<AppConstants.TetrominoType> upcoming = const [],
      final List<AppConstants.TetrominoType> bag = const []})
      : _upcoming = upcoming,
        _bag = bag;

  factory _$TetrominoQueueImpl.fromJson(Map<String, dynamic> json) =>
      _$$TetrominoQueueImplFromJson(json);

  final List<AppConstants.TetrominoType> _upcoming;
  @override
  @JsonKey()
  List<AppConstants.TetrominoType> get upcoming {
    if (_upcoming is EqualUnmodifiableListView) return _upcoming;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcoming);
  }

  final List<AppConstants.TetrominoType> _bag;
  @override
  @JsonKey()
  List<AppConstants.TetrominoType> get bag {
    if (_bag is EqualUnmodifiableListView) return _bag;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bag);
  }

  @override
  String toString() {
    return 'TetrominoQueue(upcoming: $upcoming, bag: $bag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TetrominoQueueImpl &&
            const DeepCollectionEquality().equals(other._upcoming, _upcoming) &&
            const DeepCollectionEquality().equals(other._bag, _bag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_upcoming),
      const DeepCollectionEquality().hash(_bag));

  /// Create a copy of TetrominoQueue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TetrominoQueueImplCopyWith<_$TetrominoQueueImpl> get copyWith =>
      __$$TetrominoQueueImplCopyWithImpl<_$TetrominoQueueImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<AppConstants.TetrominoType> upcoming,
            List<AppConstants.TetrominoType> bag)
        $default,
  ) {
    return $default(upcoming, bag);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<AppConstants.TetrominoType> upcoming,
            List<AppConstants.TetrominoType> bag)?
        $default,
  ) {
    return $default?.call(upcoming, bag);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<AppConstants.TetrominoType> upcoming,
            List<AppConstants.TetrominoType> bag)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(upcoming, bag);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TetrominoQueue value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TetrominoQueue value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TetrominoQueue value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TetrominoQueueImplToJson(
      this,
    );
  }
}

abstract class _TetrominoQueue implements TetrominoQueue {
  const factory _TetrominoQueue(
      {final List<AppConstants.TetrominoType> upcoming,
      final List<AppConstants.TetrominoType> bag}) = _$TetrominoQueueImpl;

  factory _TetrominoQueue.fromJson(Map<String, dynamic> json) =
      _$TetrominoQueueImpl.fromJson;

  @override
  List<AppConstants.TetrominoType> get upcoming;
  @override
  List<AppConstants.TetrominoType> get bag;

  /// Create a copy of TetrominoQueue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TetrominoQueueImplCopyWith<_$TetrominoQueueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
