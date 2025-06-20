import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../constants/game_constants.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
@HiveType(typeId: 2)
class GameBoard with _$GameBoard {
  const factory GameBoard({
    @HiveField(0) @Default([]) List<List<int>> grid,
    @HiveField(1) @Default(0) int width,
    @HiveField(2) @Default(0) int height,
  }) = _GameBoard;

  factory GameBoard.empty() => GameBoard(
    grid: List.generate(
      GameConstants.boardHeight,
      (_) => List.filled(GameConstants.boardWidth, 0),
    ),
    width: GameConstants.boardWidth,
    height: GameConstants.boardHeight,
  );

  factory GameBoard.fromJson(Map<String, dynamic> json) => _$GameBoardFromJson(json);
}

@freezed
@HiveType(typeId: 3)
class Tetromino with _$Tetromino {
  const factory Tetromino({
    @HiveField(0) required GameConstants.TetrominoType type,
    @HiveField(1) required List<List<int>> shape,
    @HiveField(2) @Default(0) int x,
    @HiveField(3) @Default(0) int y,
    @HiveField(4) @Default(0) int rotation,
  }) = _Tetromino;

  factory Tetromino.create(GameConstants.TetrominoType type) {
    final shapes = GameConstants.tetrominoShapes[type]!;
    return Tetromino(
      type: type,
      shape: shapes[0],
      x: (GameConstants.boardWidth ~/ 2) - (shapes[0][0].length ~/ 2),
      y: 0,
      rotation: 0,
    );
  }

  factory Tetromino.fromJson(Map<String, dynamic> json) => _$TetrominoFromJson(json);
}

@freezed
@HiveType(typeId: 4)
class GameState with _$GameState {
  const factory GameState({
    @HiveField(0) required GameBoard board,
    @HiveField(1) Tetromino? currentPiece,
    @HiveField(2) @Default([]) List<GameConstants.TetrominoType> nextPieces,
    @HiveField(3) Tetromino? holdPiece,
    @HiveField(4) @Default(false) bool canHold,
    @HiveField(5) @Default(0) int score,
    @HiveField(6) @Default(0) int lines,
    @HiveField(7) @Default(1) int level,
    @HiveField(8) @Default(GameStatus.playing) GameStatus status,
    @HiveField(9) @Default(0) int dropTimer,
    @HiveField(10) @Default(false) bool isPaused,
    @HiveField(11) required DateTime startTime,
    @HiveField(12) @Default(0) int combo,
    @HiveField(13) @Default(0) int tetrises,
  }) = _GameState;

  factory GameState.initial() => GameState(
    board: GameBoard.empty(),
    startTime: DateTime.now(),
  );

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
}

@freezed
@HiveType(typeId: 5)
class GameResult with _$GameResult {
  const factory GameResult({
    @HiveField(0) required String gameId,
    @HiveField(1) required String userId,
    @HiveField(2) required GameMode mode,
    @HiveField(3) required int score,
    @HiveField(4) required int lines,
    @HiveField(5) required int level,
    @HiveField(6) required Duration duration,
    @HiveField(7) required DateTime playedAt,
    @HiveField(8) @Default(0) int tetrises,
    @HiveField(9) @Default(0) int maxCombo,
    @HiveField(10) @Default(false) bool isPersonalBest,
    @HiveField(11) String? multiplayerRoomId,
    @HiveField(12) @Default([]) List<String> opponents,
    @HiveField(13) @Default(false) bool isWinner,
  }) = _GameResult;

  factory GameResult.fromJson(Map<String, dynamic> json) => _$GameResultFromJson(json);
}

@freezed
class GameSettings with _$GameSettings {
  const factory GameSettings({
    @Default(GameDifficulty.normal) GameDifficulty difficulty,
    @Default(true) bool soundEnabled,
    @Default(true) bool musicEnabled,
    @Default(0.7) double soundVolume,
    @Default(0.5) double musicVolume,
    @Default(true) bool vibrationEnabled,
    @Default(true) bool ghostPieceEnabled,
    @Default(true) bool gridLinesEnabled,
    @Default('default') String theme,
    @Default(ControlScheme.touch) ControlScheme controls,
    @Default(true) bool autoSaveEnabled,
  }) = _GameSettings;

  factory GameSettings.fromJson(Map<String, dynamic> json) => _$GameSettingsFromJson(json);
}

@HiveType(typeId: 10)
enum GameStatus {
  @HiveField(0) waiting,
  @HiveField(1) playing,
  @HiveField(2) paused,
  @HiveField(3) gameOver,
  @HiveField(4) completed,
}

@HiveType(typeId: 11)
enum GameMode {
  @HiveField(0) singlePlayer,
  @HiveField(1) vsPlayer,
  @HiveField(2) teamCooperation,
  @HiveField(3) survival,
}

@HiveType(typeId: 12)
enum GameDifficulty {
  @HiveField(0) easy,
  @HiveField(1) normal,
  @HiveField(2) hard,
  @HiveField(3) expert,
}

@HiveType(typeId: 13)
enum ControlScheme {
  @HiveField(0) touch,
  @HiveField(1) gestures,
  @HiveField(2) buttons,
}

// 게임 액션 타입
enum GameAction {
  moveLeft,
  moveRight,
  moveDown,
  hardDrop,
  rotateClockwise,
  rotateCounterClockwise,
  hold,
  pause,
}

// 멀티플레이어 액션
@freezed
class MultiplayerAction with _$MultiplayerAction {
  const factory MultiplayerAction({
    required String playerId,
    required GameAction action,
    required DateTime timestamp,
    Map<String, dynamic>? data,
  }) = _MultiplayerAction;

  factory MultiplayerAction.fromJson(Map<String, dynamic> json) => _$MultiplayerActionFromJson(json);
}

// 공격 라인 (상대방에게 보낼 방해 블록)
@freezed
class AttackLines with _$AttackLines {
  const factory AttackLines({
    required String fromPlayerId,
    required String toPlayerId,
    required int lineCount,
    required DateTime timestamp,
  }) = _AttackLines;

  factory AttackLines.fromJson(Map<String, dynamic> json) => _$AttackLinesFromJson(json);
}
