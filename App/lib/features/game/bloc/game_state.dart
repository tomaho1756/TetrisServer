part of 'game_bloc.dart';

@freezed
class GameState with _$GameState {
  const factory GameState.initial() = _Initial;
  const factory GameState.loading() = _Loading;
  const factory GameState.playing({
    required String gameId,
    required GameBoard board,
    required Tetromino? currentPiece,
    required List<Tetromino> nextPieces,
    required Tetromino? heldPiece,
    required int score,
    required int level,
    required int lines,
    required bool isGameOver,
    required bool isPaused,
  }) = _Playing;
  const factory GameState.gameOver({
    required int finalScore,
    required int level,
    required int lines,
  }) = _GameOver;
  const factory GameState.error(String message) = _Error;
}
