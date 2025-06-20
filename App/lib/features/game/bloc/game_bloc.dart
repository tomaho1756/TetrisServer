import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/game_board.dart';
import '../../../core/models/tetromino.dart';
import '../../../core/services/game_service.dart';
import '../../../core/services/socket_service.dart';

part 'game_event.dart';
part 'game_state.dart';
part 'game_bloc.freezed.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameService gameService;
  final SocketService socketService;

  GameBloc({
    required this.gameService,
    required this.socketService,
  }) : super(const GameState.initial()) {
    on<GameEvent>((event, emit) async {
      await event.when(
        startSingleGame: () async {
          emit(const GameState.loading());
          try {
            final gameSession = await gameService.startSingleGame();
            emit(GameState.playing(
              gameId: gameSession.id,
              board: gameSession.board,
              currentPiece: gameSession.currentPiece,
              nextPieces: gameSession.nextPieces,
              heldPiece: gameSession.heldPiece,
              score: gameSession.score,
              level: gameSession.level,
              lines: gameSession.linesCleared,
              isGameOver: false,
              isPaused: false,
            ));
          } catch (e) {
            emit(GameState.error(e.toString()));
          }
        },
        movePiece: (direction) async {
          final currentState = state;
          if (currentState is _Playing) {
            try {
              final updatedSession = await gameService.movePiece(
                currentState.gameId,
                direction,
              );
              emit(currentState.copyWith(
                board: updatedSession.board,
                currentPiece: updatedSession.currentPiece,
                nextPieces: updatedSession.nextPieces,
                heldPiece: updatedSession.heldPiece,
                score: updatedSession.score,
                level: updatedSession.level,
                lines: updatedSession.linesCleared,
                isGameOver: updatedSession.isGameOver,
              ));
            } catch (e) {
              emit(GameState.error(e.toString()));
            }
          }
        },
        rotatePiece: (clockwise) async {
          final currentState = state;
          if (currentState is _Playing) {
            try {
              final updatedSession = await gameService.rotatePiece(
                currentState.gameId,
                clockwise,
              );
              emit(currentState.copyWith(
                board: updatedSession.board,
                currentPiece: updatedSession.currentPiece,
              ));
            } catch (e) {
              emit(GameState.error(e.toString()));
            }
          }
        },
        dropPiece: () async {
          final currentState = state;
          if (currentState is _Playing) {
            try {
              final updatedSession = await gameService.dropPiece(
                currentState.gameId,
              );
              emit(currentState.copyWith(
                board: updatedSession.board,
                currentPiece: updatedSession.currentPiece,
                nextPieces: updatedSession.nextPieces,
                heldPiece: updatedSession.heldPiece,
                score: updatedSession.score,
                level: updatedSession.level,
                lines: updatedSession.linesCleared,
                isGameOver: updatedSession.isGameOver,
              ));
            } catch (e) {
              emit(GameState.error(e.toString()));
            }
          }
        },
        holdPiece: () async {
          final currentState = state;
          if (currentState is _Playing) {
            try {
              final updatedSession = await gameService.holdPiece(
                currentState.gameId,
              );
              emit(currentState.copyWith(
                board: updatedSession.board,
                currentPiece: updatedSession.currentPiece,
                nextPieces: updatedSession.nextPieces,
                heldPiece: updatedSession.heldPiece,
              ));
            } catch (e) {
              emit(GameState.error(e.toString()));
            }
          }
        },
        pauseGame: () {
          final currentState = state;
          if (currentState is _Playing) {
            emit(currentState.copyWith(isPaused: !currentState.isPaused));
          }
        },
        endGame: () async {
          final currentState = state;
          if (currentState is _Playing) {
            try {
              await gameService.endGame(currentState.gameId);
              emit(GameState.gameOver(
                finalScore: currentState.score,
                level: currentState.level,
                lines: currentState.lines,
              ));
            } catch (e) {
              emit(GameState.error(e.toString()));
            }
          }
        },
        restartGame: () async {
          add(const GameEvent.startSingleGame());
        },
      );
    });
  }
}
