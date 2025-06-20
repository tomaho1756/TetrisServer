// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_board.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameBoard _$GameBoardFromJson(Map<String, dynamic> json) {
  return _GameBoard.fromJson(json);
}

/// @nodoc
mixin _$GameBoard {
  List<List<Color?>> get board => throw _privateConstructorUsedError;
  Tetromino? get currentPiece => throw _privateConstructorUsedError;
  Tetromino? get ghostPiece => throw _privateConstructorUsedError;
  Tetromino? get heldPiece => throw _privateConstructorUsedError;
  List<AppConstants.TetrominoType> get nextPieces =>
      throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get lines => throw _privateConstructorUsedError;
  int get combo => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  bool get canHold => throw _privateConstructorUsedError;
  int get garbageLines => throw _privateConstructorUsedError;
  List<int> get pendingGarbage => throw _privateConstructorUsedError;
  DateTime? get lastMoveTime => throw _privateConstructorUsedError;
  DateTime? get gameStartTime => throw _privateConstructorUsedError;
  Duration? get gameDuration => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<List<Color?>> board,
            Tetromino? currentPiece,
            Tetromino? ghostPiece,
            Tetromino? heldPiece,
            List<AppConstants.TetrominoType> nextPieces,
            int score,
            int level,
            int lines,
            int combo,
            GameStatus status,
            bool canHold,
            int garbageLines,
            List<int> pendingGarbage,
            DateTime? lastMoveTime,
            DateTime? gameStartTime,
            Duration? gameDuration)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<List<Color?>> board,
            Tetromino? currentPiece,
            Tetromino? ghostPiece,
            Tetromino? heldPiece,
            List<AppConstants.TetrominoType> nextPieces,
            int score,
            int level,
            int lines,
            int combo,
            GameStatus status,
            bool canHold,
            int garbageLines,
            List<int> pendingGarbage,
            DateTime? lastMoveTime,
            DateTime? gameStartTime,
            Duration? gameDuration)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<List<Color?>> board,
            Tetromino? currentPiece,
            Tetromino? ghostPiece,
            Tetromino? heldPiece,
            List<AppConstants.TetrominoType> nextPieces,
            int score,
            int level,
            int lines,
            int combo,
            GameStatus status,
            bool canHold,
            int garbageLines,
            List<int> pendingGarbage,
            DateTime? lastMoveTime,
            DateTime? gameStartTime,
            Duration? gameDuration)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameBoard value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameBoard value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameBoard value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this GameBoard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameBoard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameBoardCopyWith<GameBoard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameBoardCopyWith<$Res> {
  factory $GameBoardCopyWith(GameBoard value, $Res Function(GameBoard) then) =
      _$GameBoardCopyWithImpl<$Res, GameBoard>;
  @useResult
  $Res call(
      {List<List<Color?>> board,
      Tetromino? currentPiece,
      Tetromino? ghostPiece,
      Tetromino? heldPiece,
      List<AppConstants.TetrominoType> nextPieces,
      int score,
      int level,
      int lines,
      int combo,
      GameStatus status,
      bool canHold,
      int garbageLines,
      List<int> pendingGarbage,
      DateTime? lastMoveTime,
      DateTime? gameStartTime,
      Duration? gameDuration});

  $TetrominoCopyWith<$Res>? get currentPiece;
  $TetrominoCopyWith<$Res>? get ghostPiece;
  $TetrominoCopyWith<$Res>? get heldPiece;
}

/// @nodoc
class _$GameBoardCopyWithImpl<$Res, $Val extends GameBoard>
    implements $GameBoardCopyWith<$Res> {
  _$GameBoardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameBoard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? currentPiece = freezed,
    Object? ghostPiece = freezed,
    Object? heldPiece = freezed,
    Object? nextPieces = null,
    Object? score = null,
    Object? level = null,
    Object? lines = null,
    Object? combo = null,
    Object? status = freezed,
    Object? canHold = null,
    Object? garbageLines = null,
    Object? pendingGarbage = null,
    Object? lastMoveTime = freezed,
    Object? gameStartTime = freezed,
    Object? gameDuration = freezed,
  }) {
    return _then(_value.copyWith(
      board: null == board
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as List<List<Color?>>,
      currentPiece: freezed == currentPiece
          ? _value.currentPiece
          : currentPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      ghostPiece: freezed == ghostPiece
          ? _value.ghostPiece
          : ghostPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      heldPiece: freezed == heldPiece
          ? _value.heldPiece
          : heldPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      nextPieces: null == nextPieces
          ? _value.nextPieces
          : nextPieces // ignore: cast_nullable_to_non_nullable
              as List<AppConstants.TetrominoType>,
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
      combo: null == combo
          ? _value.combo
          : combo // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      canHold: null == canHold
          ? _value.canHold
          : canHold // ignore: cast_nullable_to_non_nullable
              as bool,
      garbageLines: null == garbageLines
          ? _value.garbageLines
          : garbageLines // ignore: cast_nullable_to_non_nullable
              as int,
      pendingGarbage: null == pendingGarbage
          ? _value.pendingGarbage
          : pendingGarbage // ignore: cast_nullable_to_non_nullable
              as List<int>,
      lastMoveTime: freezed == lastMoveTime
          ? _value.lastMoveTime
          : lastMoveTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gameStartTime: freezed == gameStartTime
          ? _value.gameStartTime
          : gameStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gameDuration: freezed == gameDuration
          ? _value.gameDuration
          : gameDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }

  /// Create a copy of GameBoard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TetrominoCopyWith<$Res>? get currentPiece {
    if (_value.currentPiece == null) {
      return null;
    }

    return $TetrominoCopyWith<$Res>(_value.currentPiece!, (value) {
      return _then(_value.copyWith(currentPiece: value) as $Val);
    });
  }

  /// Create a copy of GameBoard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TetrominoCopyWith<$Res>? get ghostPiece {
    if (_value.ghostPiece == null) {
      return null;
    }

    return $TetrominoCopyWith<$Res>(_value.ghostPiece!, (value) {
      return _then(_value.copyWith(ghostPiece: value) as $Val);
    });
  }

  /// Create a copy of GameBoard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TetrominoCopyWith<$Res>? get heldPiece {
    if (_value.heldPiece == null) {
      return null;
    }

    return $TetrominoCopyWith<$Res>(_value.heldPiece!, (value) {
      return _then(_value.copyWith(heldPiece: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameBoardImplCopyWith<$Res>
    implements $GameBoardCopyWith<$Res> {
  factory _$$GameBoardImplCopyWith(
          _$GameBoardImpl value, $Res Function(_$GameBoardImpl) then) =
      __$$GameBoardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<List<Color?>> board,
      Tetromino? currentPiece,
      Tetromino? ghostPiece,
      Tetromino? heldPiece,
      List<AppConstants.TetrominoType> nextPieces,
      int score,
      int level,
      int lines,
      int combo,
      GameStatus status,
      bool canHold,
      int garbageLines,
      List<int> pendingGarbage,
      DateTime? lastMoveTime,
      DateTime? gameStartTime,
      Duration? gameDuration});

  @override
  $TetrominoCopyWith<$Res>? get currentPiece;
  @override
  $TetrominoCopyWith<$Res>? get ghostPiece;
  @override
  $TetrominoCopyWith<$Res>? get heldPiece;
}

/// @nodoc
class __$$GameBoardImplCopyWithImpl<$Res>
    extends _$GameBoardCopyWithImpl<$Res, _$GameBoardImpl>
    implements _$$GameBoardImplCopyWith<$Res> {
  __$$GameBoardImplCopyWithImpl(
      _$GameBoardImpl _value, $Res Function(_$GameBoardImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameBoard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? currentPiece = freezed,
    Object? ghostPiece = freezed,
    Object? heldPiece = freezed,
    Object? nextPieces = null,
    Object? score = null,
    Object? level = null,
    Object? lines = null,
    Object? combo = null,
    Object? status = freezed,
    Object? canHold = null,
    Object? garbageLines = null,
    Object? pendingGarbage = null,
    Object? lastMoveTime = freezed,
    Object? gameStartTime = freezed,
    Object? gameDuration = freezed,
  }) {
    return _then(_$GameBoardImpl(
      board: null == board
          ? _value._board
          : board // ignore: cast_nullable_to_non_nullable
              as List<List<Color?>>,
      currentPiece: freezed == currentPiece
          ? _value.currentPiece
          : currentPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      ghostPiece: freezed == ghostPiece
          ? _value.ghostPiece
          : ghostPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      heldPiece: freezed == heldPiece
          ? _value.heldPiece
          : heldPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      nextPieces: null == nextPieces
          ? _value._nextPieces
          : nextPieces // ignore: cast_nullable_to_non_nullable
              as List<AppConstants.TetrominoType>,
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
      combo: null == combo
          ? _value.combo
          : combo // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      canHold: null == canHold
          ? _value.canHold
          : canHold // ignore: cast_nullable_to_non_nullable
              as bool,
      garbageLines: null == garbageLines
          ? _value.garbageLines
          : garbageLines // ignore: cast_nullable_to_non_nullable
              as int,
      pendingGarbage: null == pendingGarbage
          ? _value._pendingGarbage
          : pendingGarbage // ignore: cast_nullable_to_non_nullable
              as List<int>,
      lastMoveTime: freezed == lastMoveTime
          ? _value.lastMoveTime
          : lastMoveTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gameStartTime: freezed == gameStartTime
          ? _value.gameStartTime
          : gameStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gameDuration: freezed == gameDuration
          ? _value.gameDuration
          : gameDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameBoardImpl implements _GameBoard {
  const _$GameBoardImpl(
      {required final List<List<Color?>> board,
      this.currentPiece,
      this.ghostPiece,
      this.heldPiece,
      final List<AppConstants.TetrominoType> nextPieces = const [],
      this.score = 0,
      this.level = 1,
      this.lines = 0,
      this.combo = 0,
      this.status = AppConstants.GameStatus.waiting,
      this.canHold = false,
      this.garbageLines = 0,
      final List<int> pendingGarbage = const [],
      this.lastMoveTime,
      this.gameStartTime,
      this.gameDuration})
      : _board = board,
        _nextPieces = nextPieces,
        _pendingGarbage = pendingGarbage;

  factory _$GameBoardImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameBoardImplFromJson(json);

  final List<List<Color?>> _board;
  @override
  List<List<Color?>> get board {
    if (_board is EqualUnmodifiableListView) return _board;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_board);
  }

  @override
  final Tetromino? currentPiece;
  @override
  final Tetromino? ghostPiece;
  @override
  final Tetromino? heldPiece;
  final List<AppConstants.TetrominoType> _nextPieces;
  @override
  @JsonKey()
  List<AppConstants.TetrominoType> get nextPieces {
    if (_nextPieces is EqualUnmodifiableListView) return _nextPieces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nextPieces);
  }

  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int lines;
  @override
  @JsonKey()
  final int combo;
  @override
  @JsonKey()
  final GameStatus status;
  @override
  @JsonKey()
  final bool canHold;
  @override
  @JsonKey()
  final int garbageLines;
  final List<int> _pendingGarbage;
  @override
  @JsonKey()
  List<int> get pendingGarbage {
    if (_pendingGarbage is EqualUnmodifiableListView) return _pendingGarbage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingGarbage);
  }

  @override
  final DateTime? lastMoveTime;
  @override
  final DateTime? gameStartTime;
  @override
  final Duration? gameDuration;

  @override
  String toString() {
    return 'GameBoard(board: $board, currentPiece: $currentPiece, ghostPiece: $ghostPiece, heldPiece: $heldPiece, nextPieces: $nextPieces, score: $score, level: $level, lines: $lines, combo: $combo, status: $status, canHold: $canHold, garbageLines: $garbageLines, pendingGarbage: $pendingGarbage, lastMoveTime: $lastMoveTime, gameStartTime: $gameStartTime, gameDuration: $gameDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameBoardImpl &&
            const DeepCollectionEquality().equals(other._board, _board) &&
            (identical(other.currentPiece, currentPiece) ||
                other.currentPiece == currentPiece) &&
            (identical(other.ghostPiece, ghostPiece) ||
                other.ghostPiece == ghostPiece) &&
            (identical(other.heldPiece, heldPiece) ||
                other.heldPiece == heldPiece) &&
            const DeepCollectionEquality()
                .equals(other._nextPieces, _nextPieces) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.lines, lines) || other.lines == lines) &&
            (identical(other.combo, combo) || other.combo == combo) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            (identical(other.canHold, canHold) || other.canHold == canHold) &&
            (identical(other.garbageLines, garbageLines) ||
                other.garbageLines == garbageLines) &&
            const DeepCollectionEquality()
                .equals(other._pendingGarbage, _pendingGarbage) &&
            (identical(other.lastMoveTime, lastMoveTime) ||
                other.lastMoveTime == lastMoveTime) &&
            (identical(other.gameStartTime, gameStartTime) ||
                other.gameStartTime == gameStartTime) &&
            (identical(other.gameDuration, gameDuration) ||
                other.gameDuration == gameDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_board),
      currentPiece,
      ghostPiece,
      heldPiece,
      const DeepCollectionEquality().hash(_nextPieces),
      score,
      level,
      lines,
      combo,
      const DeepCollectionEquality().hash(status),
      canHold,
      garbageLines,
      const DeepCollectionEquality().hash(_pendingGarbage),
      lastMoveTime,
      gameStartTime,
      gameDuration);

  /// Create a copy of GameBoard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameBoardImplCopyWith<_$GameBoardImpl> get copyWith =>
      __$$GameBoardImplCopyWithImpl<_$GameBoardImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<List<Color?>> board,
            Tetromino? currentPiece,
            Tetromino? ghostPiece,
            Tetromino? heldPiece,
            List<AppConstants.TetrominoType> nextPieces,
            int score,
            int level,
            int lines,
            int combo,
            GameStatus status,
            bool canHold,
            int garbageLines,
            List<int> pendingGarbage,
            DateTime? lastMoveTime,
            DateTime? gameStartTime,
            Duration? gameDuration)
        $default,
  ) {
    return $default(
        board,
        currentPiece,
        ghostPiece,
        heldPiece,
        nextPieces,
        score,
        level,
        lines,
        combo,
        status,
        canHold,
        garbageLines,
        pendingGarbage,
        lastMoveTime,
        gameStartTime,
        gameDuration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<List<Color?>> board,
            Tetromino? currentPiece,
            Tetromino? ghostPiece,
            Tetromino? heldPiece,
            List<AppConstants.TetrominoType> nextPieces,
            int score,
            int level,
            int lines,
            int combo,
            GameStatus status,
            bool canHold,
            int garbageLines,
            List<int> pendingGarbage,
            DateTime? lastMoveTime,
            DateTime? gameStartTime,
            Duration? gameDuration)?
        $default,
  ) {
    return $default?.call(
        board,
        currentPiece,
        ghostPiece,
        heldPiece,
        nextPieces,
        score,
        level,
        lines,
        combo,
        status,
        canHold,
        garbageLines,
        pendingGarbage,
        lastMoveTime,
        gameStartTime,
        gameDuration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<List<Color?>> board,
            Tetromino? currentPiece,
            Tetromino? ghostPiece,
            Tetromino? heldPiece,
            List<AppConstants.TetrominoType> nextPieces,
            int score,
            int level,
            int lines,
            int combo,
            GameStatus status,
            bool canHold,
            int garbageLines,
            List<int> pendingGarbage,
            DateTime? lastMoveTime,
            DateTime? gameStartTime,
            Duration? gameDuration)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          board,
          currentPiece,
          ghostPiece,
          heldPiece,
          nextPieces,
          score,
          level,
          lines,
          combo,
          status,
          canHold,
          garbageLines,
          pendingGarbage,
          lastMoveTime,
          gameStartTime,
          gameDuration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameBoard value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameBoard value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameBoard value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GameBoardImplToJson(
      this,
    );
  }
}

abstract class _GameBoard implements GameBoard {
  const factory _GameBoard(
      {required final List<List<Color?>> board,
      final Tetromino? currentPiece,
      final Tetromino? ghostPiece,
      final Tetromino? heldPiece,
      final List<AppConstants.TetrominoType> nextPieces,
      final int score,
      final int level,
      final int lines,
      final int combo,
      final GameStatus status,
      final bool canHold,
      final int garbageLines,
      final List<int> pendingGarbage,
      final DateTime? lastMoveTime,
      final DateTime? gameStartTime,
      final Duration? gameDuration}) = _$GameBoardImpl;

  factory _GameBoard.fromJson(Map<String, dynamic> json) =
      _$GameBoardImpl.fromJson;

  @override
  List<List<Color?>> get board;
  @override
  Tetromino? get currentPiece;
  @override
  Tetromino? get ghostPiece;
  @override
  Tetromino? get heldPiece;
  @override
  List<AppConstants.TetrominoType> get nextPieces;
  @override
  int get score;
  @override
  int get level;
  @override
  int get lines;
  @override
  int get combo;
  @override
  GameStatus get status;
  @override
  bool get canHold;
  @override
  int get garbageLines;
  @override
  List<int> get pendingGarbage;
  @override
  DateTime? get lastMoveTime;
  @override
  DateTime? get gameStartTime;
  @override
  Duration? get gameDuration;

  /// Create a copy of GameBoard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameBoardImplCopyWith<_$GameBoardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  GameBoard get board => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  bool get isGameOver => throw _privateConstructorUsedError;
  int get totalScore => throw _privateConstructorUsedError;
  int get totalLines => throw _privateConstructorUsedError;
  int get currentLevel => throw _privateConstructorUsedError;
  int get attackSent => throw _privateConstructorUsedError;
  int get attackReceived => throw _privateConstructorUsedError;
  bool get perfectClear => throw _privateConstructorUsedError;
  bool get isTSpin => throw _privateConstructorUsedError;
  int get maxCombo => throw _privateConstructorUsedError;
  Map<String, dynamic> get statistics => throw _privateConstructorUsedError;
  String? get gameId => throw _privateConstructorUsedError;
  String? get gameMode => throw _privateConstructorUsedError;
  List<GameEvent> get events => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            GameBoard board,
            bool isPaused,
            bool isGameOver,
            int totalScore,
            int totalLines,
            int currentLevel,
            int attackSent,
            int attackReceived,
            bool perfectClear,
            bool isTSpin,
            int maxCombo,
            Map<String, dynamic> statistics,
            String? gameId,
            String? gameMode,
            List<GameEvent> events)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            GameBoard board,
            bool isPaused,
            bool isGameOver,
            int totalScore,
            int totalLines,
            int currentLevel,
            int attackSent,
            int attackReceived,
            bool perfectClear,
            bool isTSpin,
            int maxCombo,
            Map<String, dynamic> statistics,
            String? gameId,
            String? gameMode,
            List<GameEvent> events)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            GameBoard board,
            bool isPaused,
            bool isGameOver,
            int totalScore,
            int totalLines,
            int currentLevel,
            int attackSent,
            int attackReceived,
            bool perfectClear,
            bool isTSpin,
            int maxCombo,
            Map<String, dynamic> statistics,
            String? gameId,
            String? gameMode,
            List<GameEvent> events)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameState value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameState value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameState value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {GameBoard board,
      bool isPaused,
      bool isGameOver,
      int totalScore,
      int totalLines,
      int currentLevel,
      int attackSent,
      int attackReceived,
      bool perfectClear,
      bool isTSpin,
      int maxCombo,
      Map<String, dynamic> statistics,
      String? gameId,
      String? gameMode,
      List<GameEvent> events});

  $GameBoardCopyWith<$Res> get board;
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? isPaused = null,
    Object? isGameOver = null,
    Object? totalScore = null,
    Object? totalLines = null,
    Object? currentLevel = null,
    Object? attackSent = null,
    Object? attackReceived = null,
    Object? perfectClear = null,
    Object? isTSpin = null,
    Object? maxCombo = null,
    Object? statistics = null,
    Object? gameId = freezed,
    Object? gameMode = freezed,
    Object? events = null,
  }) {
    return _then(_value.copyWith(
      board: null == board
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as GameBoard,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isGameOver: null == isGameOver
          ? _value.isGameOver
          : isGameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalLines: null == totalLines
          ? _value.totalLines
          : totalLines // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      attackSent: null == attackSent
          ? _value.attackSent
          : attackSent // ignore: cast_nullable_to_non_nullable
              as int,
      attackReceived: null == attackReceived
          ? _value.attackReceived
          : attackReceived // ignore: cast_nullable_to_non_nullable
              as int,
      perfectClear: null == perfectClear
          ? _value.perfectClear
          : perfectClear // ignore: cast_nullable_to_non_nullable
              as bool,
      isTSpin: null == isTSpin
          ? _value.isTSpin
          : isTSpin // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCombo: null == maxCombo
          ? _value.maxCombo
          : maxCombo // ignore: cast_nullable_to_non_nullable
              as int,
      statistics: null == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String?,
      gameMode: freezed == gameMode
          ? _value.gameMode
          : gameMode // ignore: cast_nullable_to_non_nullable
              as String?,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<GameEvent>,
    ) as $Val);
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameBoardCopyWith<$Res> get board {
    return $GameBoardCopyWith<$Res>(_value.board, (value) {
      return _then(_value.copyWith(board: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameBoard board,
      bool isPaused,
      bool isGameOver,
      int totalScore,
      int totalLines,
      int currentLevel,
      int attackSent,
      int attackReceived,
      bool perfectClear,
      bool isTSpin,
      int maxCombo,
      Map<String, dynamic> statistics,
      String? gameId,
      String? gameMode,
      List<GameEvent> events});

  @override
  $GameBoardCopyWith<$Res> get board;
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? isPaused = null,
    Object? isGameOver = null,
    Object? totalScore = null,
    Object? totalLines = null,
    Object? currentLevel = null,
    Object? attackSent = null,
    Object? attackReceived = null,
    Object? perfectClear = null,
    Object? isTSpin = null,
    Object? maxCombo = null,
    Object? statistics = null,
    Object? gameId = freezed,
    Object? gameMode = freezed,
    Object? events = null,
  }) {
    return _then(_$GameStateImpl(
      board: null == board
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as GameBoard,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isGameOver: null == isGameOver
          ? _value.isGameOver
          : isGameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalLines: null == totalLines
          ? _value.totalLines
          : totalLines // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      attackSent: null == attackSent
          ? _value.attackSent
          : attackSent // ignore: cast_nullable_to_non_nullable
              as int,
      attackReceived: null == attackReceived
          ? _value.attackReceived
          : attackReceived // ignore: cast_nullable_to_non_nullable
              as int,
      perfectClear: null == perfectClear
          ? _value.perfectClear
          : perfectClear // ignore: cast_nullable_to_non_nullable
              as bool,
      isTSpin: null == isTSpin
          ? _value.isTSpin
          : isTSpin // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCombo: null == maxCombo
          ? _value.maxCombo
          : maxCombo // ignore: cast_nullable_to_non_nullable
              as int,
      statistics: null == statistics
          ? _value._statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String?,
      gameMode: freezed == gameMode
          ? _value.gameMode
          : gameMode // ignore: cast_nullable_to_non_nullable
              as String?,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<GameEvent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl implements _GameState {
  const _$GameStateImpl(
      {required this.board,
      this.isPaused = false,
      this.isGameOver = false,
      this.totalScore = 0,
      this.totalLines = 0,
      this.currentLevel = 1,
      this.attackSent = 0,
      this.attackReceived = 0,
      this.perfectClear = false,
      this.isTSpin = false,
      this.maxCombo = 0,
      final Map<String, dynamic> statistics = const {},
      this.gameId,
      this.gameMode,
      final List<GameEvent> events = const []})
      : _statistics = statistics,
        _events = events;

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  @override
  final GameBoard board;
  @override
  @JsonKey()
  final bool isPaused;
  @override
  @JsonKey()
  final bool isGameOver;
  @override
  @JsonKey()
  final int totalScore;
  @override
  @JsonKey()
  final int totalLines;
  @override
  @JsonKey()
  final int currentLevel;
  @override
  @JsonKey()
  final int attackSent;
  @override
  @JsonKey()
  final int attackReceived;
  @override
  @JsonKey()
  final bool perfectClear;
  @override
  @JsonKey()
  final bool isTSpin;
  @override
  @JsonKey()
  final int maxCombo;
  final Map<String, dynamic> _statistics;
  @override
  @JsonKey()
  Map<String, dynamic> get statistics {
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statistics);
  }

  @override
  final String? gameId;
  @override
  final String? gameMode;
  final List<GameEvent> _events;
  @override
  @JsonKey()
  List<GameEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'GameState(board: $board, isPaused: $isPaused, isGameOver: $isGameOver, totalScore: $totalScore, totalLines: $totalLines, currentLevel: $currentLevel, attackSent: $attackSent, attackReceived: $attackReceived, perfectClear: $perfectClear, isTSpin: $isTSpin, maxCombo: $maxCombo, statistics: $statistics, gameId: $gameId, gameMode: $gameMode, events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.board, board) || other.board == board) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            (identical(other.isGameOver, isGameOver) ||
                other.isGameOver == isGameOver) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.totalLines, totalLines) ||
                other.totalLines == totalLines) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.attackSent, attackSent) ||
                other.attackSent == attackSent) &&
            (identical(other.attackReceived, attackReceived) ||
                other.attackReceived == attackReceived) &&
            (identical(other.perfectClear, perfectClear) ||
                other.perfectClear == perfectClear) &&
            (identical(other.isTSpin, isTSpin) || other.isTSpin == isTSpin) &&
            (identical(other.maxCombo, maxCombo) ||
                other.maxCombo == maxCombo) &&
            const DeepCollectionEquality()
                .equals(other._statistics, _statistics) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.gameMode, gameMode) ||
                other.gameMode == gameMode) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      board,
      isPaused,
      isGameOver,
      totalScore,
      totalLines,
      currentLevel,
      attackSent,
      attackReceived,
      perfectClear,
      isTSpin,
      maxCombo,
      const DeepCollectionEquality().hash(_statistics),
      gameId,
      gameMode,
      const DeepCollectionEquality().hash(_events));

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            GameBoard board,
            bool isPaused,
            bool isGameOver,
            int totalScore,
            int totalLines,
            int currentLevel,
            int attackSent,
            int attackReceived,
            bool perfectClear,
            bool isTSpin,
            int maxCombo,
            Map<String, dynamic> statistics,
            String? gameId,
            String? gameMode,
            List<GameEvent> events)
        $default,
  ) {
    return $default(
        board,
        isPaused,
        isGameOver,
        totalScore,
        totalLines,
        currentLevel,
        attackSent,
        attackReceived,
        perfectClear,
        isTSpin,
        maxCombo,
        statistics,
        gameId,
        gameMode,
        events);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            GameBoard board,
            bool isPaused,
            bool isGameOver,
            int totalScore,
            int totalLines,
            int currentLevel,
            int attackSent,
            int attackReceived,
            bool perfectClear,
            bool isTSpin,
            int maxCombo,
            Map<String, dynamic> statistics,
            String? gameId,
            String? gameMode,
            List<GameEvent> events)?
        $default,
  ) {
    return $default?.call(
        board,
        isPaused,
        isGameOver,
        totalScore,
        totalLines,
        currentLevel,
        attackSent,
        attackReceived,
        perfectClear,
        isTSpin,
        maxCombo,
        statistics,
        gameId,
        gameMode,
        events);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            GameBoard board,
            bool isPaused,
            bool isGameOver,
            int totalScore,
            int totalLines,
            int currentLevel,
            int attackSent,
            int attackReceived,
            bool perfectClear,
            bool isTSpin,
            int maxCombo,
            Map<String, dynamic> statistics,
            String? gameId,
            String? gameMode,
            List<GameEvent> events)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          board,
          isPaused,
          isGameOver,
          totalScore,
          totalLines,
          currentLevel,
          attackSent,
          attackReceived,
          perfectClear,
          isTSpin,
          maxCombo,
          statistics,
          gameId,
          gameMode,
          events);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameState value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameState value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameState value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(
      this,
    );
  }
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {required final GameBoard board,
      final bool isPaused,
      final bool isGameOver,
      final int totalScore,
      final int totalLines,
      final int currentLevel,
      final int attackSent,
      final int attackReceived,
      final bool perfectClear,
      final bool isTSpin,
      final int maxCombo,
      final Map<String, dynamic> statistics,
      final String? gameId,
      final String? gameMode,
      final List<GameEvent> events}) = _$GameStateImpl;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  GameBoard get board;
  @override
  bool get isPaused;
  @override
  bool get isGameOver;
  @override
  int get totalScore;
  @override
  int get totalLines;
  @override
  int get currentLevel;
  @override
  int get attackSent;
  @override
  int get attackReceived;
  @override
  bool get perfectClear;
  @override
  bool get isTSpin;
  @override
  int get maxCombo;
  @override
  Map<String, dynamic> get statistics;
  @override
  String? get gameId;
  @override
  String? get gameMode;
  @override
  List<GameEvent> get events;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameEvent _$GameEventFromJson(Map<String, dynamic> json) {
  return _GameEvent.fromJson(json);
}

/// @nodoc
mixin _$GameEvent {
  String get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String type, DateTime timestamp, Map<String, dynamic> data)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String type, DateTime timestamp, Map<String, dynamic> data)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String type, DateTime timestamp, Map<String, dynamic> data)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameEvent value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameEvent value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameEvent value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this GameEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameEventCopyWith<GameEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventCopyWith<$Res> {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) then) =
      _$GameEventCopyWithImpl<$Res, GameEvent>;
  @useResult
  $Res call({String type, DateTime timestamp, Map<String, dynamic> data});
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? timestamp = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameEventImplCopyWith<$Res>
    implements $GameEventCopyWith<$Res> {
  factory _$$GameEventImplCopyWith(
          _$GameEventImpl value, $Res Function(_$GameEventImpl) then) =
      __$$GameEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, DateTime timestamp, Map<String, dynamic> data});
}

/// @nodoc
class __$$GameEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameEventImpl>
    implements _$$GameEventImplCopyWith<$Res> {
  __$$GameEventImplCopyWithImpl(
      _$GameEventImpl _value, $Res Function(_$GameEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? timestamp = null,
    Object? data = null,
  }) {
    return _then(_$GameEventImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameEventImpl implements _GameEvent {
  const _$GameEventImpl(
      {required this.type,
      required this.timestamp,
      final Map<String, dynamic> data = const {}})
      : _data = data;

  factory _$GameEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameEventImplFromJson(json);

  @override
  final String type;
  @override
  final DateTime timestamp;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'GameEvent(type: $type, timestamp: $timestamp, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEventImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, timestamp, const DeepCollectionEquality().hash(_data));

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      __$$GameEventImplCopyWithImpl<_$GameEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String type, DateTime timestamp, Map<String, dynamic> data)
        $default,
  ) {
    return $default(type, timestamp, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String type, DateTime timestamp, Map<String, dynamic> data)?
        $default,
  ) {
    return $default?.call(type, timestamp, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String type, DateTime timestamp, Map<String, dynamic> data)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(type, timestamp, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameEvent value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameEvent value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameEvent value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GameEventImplToJson(
      this,
    );
  }
}

abstract class _GameEvent implements GameEvent {
  const factory _GameEvent(
      {required final String type,
      required final DateTime timestamp,
      final Map<String, dynamic> data}) = _$GameEventImpl;

  factory _GameEvent.fromJson(Map<String, dynamic> json) =
      _$GameEventImpl.fromJson;

  @override
  String get type;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic> get data;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MovementResult _$MovementResultFromJson(Map<String, dynamic> json) {
  return _MovementResult.fromJson(json);
}

/// @nodoc
mixin _$MovementResult {
  bool get success => throw _privateConstructorUsedError;
  Tetromino? get newPiece => throw _privateConstructorUsedError;
  List<int> get clearedLines => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  bool get isTSpin => throw _privateConstructorUsedError;
  bool get isPerfectClear => throw _privateConstructorUsedError;
  int get attackLines => throw _privateConstructorUsedError;
  String? get eventType => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool success,
            Tetromino? newPiece,
            List<int> clearedLines,
            int score,
            bool isTSpin,
            bool isPerfectClear,
            int attackLines,
            String? eventType)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            bool success,
            Tetromino? newPiece,
            List<int> clearedLines,
            int score,
            bool isTSpin,
            bool isPerfectClear,
            int attackLines,
            String? eventType)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            bool success,
            Tetromino? newPiece,
            List<int> clearedLines,
            int score,
            bool isTSpin,
            bool isPerfectClear,
            int attackLines,
            String? eventType)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MovementResult value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MovementResult value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MovementResult value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this MovementResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovementResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovementResultCopyWith<MovementResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovementResultCopyWith<$Res> {
  factory $MovementResultCopyWith(
          MovementResult value, $Res Function(MovementResult) then) =
      _$MovementResultCopyWithImpl<$Res, MovementResult>;
  @useResult
  $Res call(
      {bool success,
      Tetromino? newPiece,
      List<int> clearedLines,
      int score,
      bool isTSpin,
      bool isPerfectClear,
      int attackLines,
      String? eventType});

  $TetrominoCopyWith<$Res>? get newPiece;
}

/// @nodoc
class _$MovementResultCopyWithImpl<$Res, $Val extends MovementResult>
    implements $MovementResultCopyWith<$Res> {
  _$MovementResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovementResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? newPiece = freezed,
    Object? clearedLines = null,
    Object? score = null,
    Object? isTSpin = null,
    Object? isPerfectClear = null,
    Object? attackLines = null,
    Object? eventType = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      newPiece: freezed == newPiece
          ? _value.newPiece
          : newPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      clearedLines: null == clearedLines
          ? _value.clearedLines
          : clearedLines // ignore: cast_nullable_to_non_nullable
              as List<int>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      isTSpin: null == isTSpin
          ? _value.isTSpin
          : isTSpin // ignore: cast_nullable_to_non_nullable
              as bool,
      isPerfectClear: null == isPerfectClear
          ? _value.isPerfectClear
          : isPerfectClear // ignore: cast_nullable_to_non_nullable
              as bool,
      attackLines: null == attackLines
          ? _value.attackLines
          : attackLines // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: freezed == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MovementResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TetrominoCopyWith<$Res>? get newPiece {
    if (_value.newPiece == null) {
      return null;
    }

    return $TetrominoCopyWith<$Res>(_value.newPiece!, (value) {
      return _then(_value.copyWith(newPiece: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MovementResultImplCopyWith<$Res>
    implements $MovementResultCopyWith<$Res> {
  factory _$$MovementResultImplCopyWith(_$MovementResultImpl value,
          $Res Function(_$MovementResultImpl) then) =
      __$$MovementResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      Tetromino? newPiece,
      List<int> clearedLines,
      int score,
      bool isTSpin,
      bool isPerfectClear,
      int attackLines,
      String? eventType});

  @override
  $TetrominoCopyWith<$Res>? get newPiece;
}

/// @nodoc
class __$$MovementResultImplCopyWithImpl<$Res>
    extends _$MovementResultCopyWithImpl<$Res, _$MovementResultImpl>
    implements _$$MovementResultImplCopyWith<$Res> {
  __$$MovementResultImplCopyWithImpl(
      _$MovementResultImpl _value, $Res Function(_$MovementResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovementResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? newPiece = freezed,
    Object? clearedLines = null,
    Object? score = null,
    Object? isTSpin = null,
    Object? isPerfectClear = null,
    Object? attackLines = null,
    Object? eventType = freezed,
  }) {
    return _then(_$MovementResultImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      newPiece: freezed == newPiece
          ? _value.newPiece
          : newPiece // ignore: cast_nullable_to_non_nullable
              as Tetromino?,
      clearedLines: null == clearedLines
          ? _value._clearedLines
          : clearedLines // ignore: cast_nullable_to_non_nullable
              as List<int>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      isTSpin: null == isTSpin
          ? _value.isTSpin
          : isTSpin // ignore: cast_nullable_to_non_nullable
              as bool,
      isPerfectClear: null == isPerfectClear
          ? _value.isPerfectClear
          : isPerfectClear // ignore: cast_nullable_to_non_nullable
              as bool,
      attackLines: null == attackLines
          ? _value.attackLines
          : attackLines // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: freezed == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovementResultImpl implements _MovementResult {
  const _$MovementResultImpl(
      {required this.success,
      this.newPiece,
      final List<int> clearedLines = const [],
      this.score = 0,
      this.isTSpin = false,
      this.isPerfectClear = false,
      this.attackLines = 0,
      this.eventType})
      : _clearedLines = clearedLines;

  factory _$MovementResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovementResultImplFromJson(json);

  @override
  final bool success;
  @override
  final Tetromino? newPiece;
  final List<int> _clearedLines;
  @override
  @JsonKey()
  List<int> get clearedLines {
    if (_clearedLines is EqualUnmodifiableListView) return _clearedLines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clearedLines);
  }

  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final bool isTSpin;
  @override
  @JsonKey()
  final bool isPerfectClear;
  @override
  @JsonKey()
  final int attackLines;
  @override
  final String? eventType;

  @override
  String toString() {
    return 'MovementResult(success: $success, newPiece: $newPiece, clearedLines: $clearedLines, score: $score, isTSpin: $isTSpin, isPerfectClear: $isPerfectClear, attackLines: $attackLines, eventType: $eventType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovementResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.newPiece, newPiece) ||
                other.newPiece == newPiece) &&
            const DeepCollectionEquality()
                .equals(other._clearedLines, _clearedLines) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.isTSpin, isTSpin) || other.isTSpin == isTSpin) &&
            (identical(other.isPerfectClear, isPerfectClear) ||
                other.isPerfectClear == isPerfectClear) &&
            (identical(other.attackLines, attackLines) ||
                other.attackLines == attackLines) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      newPiece,
      const DeepCollectionEquality().hash(_clearedLines),
      score,
      isTSpin,
      isPerfectClear,
      attackLines,
      eventType);

  /// Create a copy of MovementResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovementResultImplCopyWith<_$MovementResultImpl> get copyWith =>
      __$$MovementResultImplCopyWithImpl<_$MovementResultImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool success,
            Tetromino? newPiece,
            List<int> clearedLines,
            int score,
            bool isTSpin,
            bool isPerfectClear,
            int attackLines,
            String? eventType)
        $default,
  ) {
    return $default(success, newPiece, clearedLines, score, isTSpin,
        isPerfectClear, attackLines, eventType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            bool success,
            Tetromino? newPiece,
            List<int> clearedLines,
            int score,
            bool isTSpin,
            bool isPerfectClear,
            int attackLines,
            String? eventType)?
        $default,
  ) {
    return $default?.call(success, newPiece, clearedLines, score, isTSpin,
        isPerfectClear, attackLines, eventType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            bool success,
            Tetromino? newPiece,
            List<int> clearedLines,
            int score,
            bool isTSpin,
            bool isPerfectClear,
            int attackLines,
            String? eventType)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(success, newPiece, clearedLines, score, isTSpin,
          isPerfectClear, attackLines, eventType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MovementResult value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MovementResult value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MovementResult value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MovementResultImplToJson(
      this,
    );
  }
}

abstract class _MovementResult implements MovementResult {
  const factory _MovementResult(
      {required final bool success,
      final Tetromino? newPiece,
      final List<int> clearedLines,
      final int score,
      final bool isTSpin,
      final bool isPerfectClear,
      final int attackLines,
      final String? eventType}) = _$MovementResultImpl;

  factory _MovementResult.fromJson(Map<String, dynamic> json) =
      _$MovementResultImpl.fromJson;

  @override
  bool get success;
  @override
  Tetromino? get newPiece;
  @override
  List<int> get clearedLines;
  @override
  int get score;
  @override
  bool get isTSpin;
  @override
  bool get isPerfectClear;
  @override
  int get attackLines;
  @override
  String? get eventType;

  /// Create a copy of MovementResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovementResultImplCopyWith<_$MovementResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
