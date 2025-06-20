part of 'game_bloc.dart';

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent.startSingleGame() = _StartSingleGame;
  const factory GameEvent.movePiece(String direction) = _MovePiece;
  const factory GameEvent.rotatePiece(bool clockwise) = _RotatePiece;
  const factory GameEvent.dropPiece() = _DropPiece;
  const factory GameEvent.holdPiece() = _HoldPiece;
  const factory GameEvent.pauseGame() = _PauseGame;
  const factory GameEvent.endGame() = _EndGame;
  const factory GameEvent.restartGame() = _RestartGame;
}
