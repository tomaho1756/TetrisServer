import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../constants/app_constants.dart';
import 'tetromino.dart';

part 'game_board.freezed.dart';
part 'game_board.g.dart';

@freezed
class GameBoard with _$GameBoard {
  const factory GameBoard({
    required List<List<Color?>> board,
    Tetromino? currentPiece,
    Tetromino? ghostPiece,
    Tetromino? heldPiece,
    @Default([]) List<AppConstants.TetrominoType> nextPieces,
    @Default(0) int score,
    @Default(1) int level,
    @Default(0) int lines,
    @Default(0) int combo,
    @Default(AppConstants.GameStatus.waiting) AppConstants.GameStatus status,
    @Default(false) bool canHold,
    @Default(0) int garbageLines,
    @Default([]) List<int> pendingGarbage,
    DateTime? lastMoveTime,
    DateTime? gameStartTime,
    Duration? gameDuration,
  }) = _GameBoard;

  factory GameBoard.fromJson(Map<String, dynamic> json) => _$GameBoardFromJson(json);

  factory GameBoard.empty() {
    return GameBoard(
      board: List.generate(
        AppConstants.boardHeight,
        (i) => List.generate(AppConstants.boardWidth, (j) => null),
      ),
      nextPieces: TetrominoGenerator.getNextN(5),
    );
  }
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    required GameBoard board,
    @Default(false) bool isPaused,
    @Default(false) bool isGameOver,
    @Default(0) int totalScore,
    @Default(0) int totalLines,
    @Default(1) int currentLevel,
    @Default(0) int attackSent,
    @Default(0) int attackReceived,
    @Default(false) bool perfectClear,
    @Default(false) bool isTSpin,
    @Default(0) int maxCombo,
    @Default({}) Map<String, dynamic> statistics,
    String? gameId,
    String? gameMode,
    @Default([]) List<GameEvent> events,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
}

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent({
    required String type,
    required DateTime timestamp,
    @Default({}) Map<String, dynamic> data,
  }) = _GameEvent;

  factory GameEvent.fromJson(Map<String, dynamic> json) => _$GameEventFromJson(json);
}

@freezed
class MovementResult with _$MovementResult {
  const factory MovementResult({
    required bool success,
    Tetromino? newPiece,
    @Default([]) List<int> clearedLines,
    @Default(0) int score,
    @Default(false) bool isTSpin,
    @Default(false) bool isPerfectClear,
    @Default(0) int attackLines,
    String? eventType,
  }) = _MovementResult;

  factory MovementResult.fromJson(Map<String, dynamic> json) => _$MovementResultFromJson(json);
}

// 확장 메서드들
extension GameBoardExtension on GameBoard {
  bool isValidPosition(Tetromino piece) {
    final positions = piece.getBlockPositions();
    
    for (final pos in positions) {
      // 보드 경계 체크
      if (pos.x < 0 || pos.x >= AppConstants.boardWidth || pos.y >= AppConstants.boardHeight) {
        return false;
      }
      
      // 다른 블록과 충돌 체크 (y < 0은 허용 - 생성 시)
      if (pos.y >= 0 && board[pos.y][pos.x] != null) {
        return false;
      }
    }
    
    return true;
  }

  GameBoard placePiece(Tetromino piece) {
    final newBoard = board.map((row) => List<Color?>.from(row)).toList();
    final positions = piece.getBlockPositions();

    for (final pos in positions) {
      if (pos.y >= 0 && pos.y < AppConstants.boardHeight && 
          pos.x >= 0 && pos.x < AppConstants.boardWidth) {
        newBoard[pos.y][pos.x] = piece.color;
      }
    }

    return copyWith(board: newBoard);
  }

  List<int> getFullLines() {
    final List<int> fullLines = [];
    
    for (int y = 0; y < AppConstants.boardHeight; y++) {
      bool isFull = true;
      for (int x = 0; x < AppConstants.boardWidth; x++) {
        if (board[y][x] == null) {
          isFull = false;
          break;
        }
      }
      if (isFull) {
        fullLines.add(y);
      }
    }
    
    return fullLines;
  }

  GameBoard clearLines(List<int> linesToClear) {
    if (linesToClear.isEmpty) return this;

    final newBoard = <List<Color?>>[];
    
    // 클리어되지 않은 라인들만 수집
    for (int y = 0; y < AppConstants.boardHeight; y++) {
      if (!linesToClear.contains(y)) {
        newBoard.add(List<Color?>.from(board[y]));
      }
    }
    
    // 상단에 빈 라인 추가
    while (newBoard.length < AppConstants.boardHeight) {
      newBoard.insert(0, List.generate(AppConstants.boardWidth, (i) => null));
    }

    final newLines = lines + linesToClear.length;
    final newLevel = (newLines ~/ AppConstants.linesPerLevel) + 1;
    final lineScore = _calculateLineScore(linesToClear.length, level);
    final newScore = score + lineScore;

    return copyWith(
      board: newBoard,
      lines: newLines,
      level: newLevel,
      score: newScore,
    );
  }

  int _calculateLineScore(int linesCleared, int currentLevel) {
    final baseScore = AppConstants.lineScores[linesCleared] ?? 0;
    return baseScore * currentLevel;
  }

  GameBoard addGarbageLines(int count) {
    if (count <= 0) return this;

    final newBoard = List<List<Color?>>.from(board);
    
    // 기존 라인들을 위로 이동
    for (int i = 0; i < AppConstants.boardHeight - count; i++) {
      newBoard[i] = List<Color?>.from(board[i + count]);
    }
    
    // 하단에 가비지 라인 추가
    for (int i = AppConstants.boardHeight - count; i < AppConstants.boardHeight; i++) {
      final garbageLine = List.generate(AppConstants.boardWidth, (j) {
        return j == (i % AppConstants.boardWidth) ? null : Colors.grey[600];
      });
      newBoard[i] = garbageLine;
    }

    return copyWith(
      board: newBoard,
      garbageLines: garbageLines + count,
    );
  }

  Tetromino? calculateGhostPiece() {
    if (currentPiece == null) return null;

    Tetromino ghost = currentPiece!.asGhost();
    
    // 아래로 계속 이동하면서 최종 위치 찾기
    while (isValidPosition(ghost.moveBy(0, 1))) {
      ghost = ghost.moveBy(0, 1);
    }
    
    return ghost;
  }

  bool isGameOver() {
    // 새 피스가 생성될 수 없으면 게임 오버
    if (currentPiece != null && !isValidPosition(currentPiece!)) {
      return true;
    }
    
    // 상단 4줄에 블록이 있으면 게임 오버
    for (int y = 0; y < 4; y++) {
      for (int x = 0; x < AppConstants.boardWidth; x++) {
        if (board[y][x] != null) {
          return true;
        }
      }
    }
    
    return false;
  }

  bool isPerfectClear() {
    for (int y = 0; y < AppConstants.boardHeight; y++) {
      for (int x = 0; x < AppConstants.boardWidth; x++) {
        if (board[y][x] != null) {
          return false;
        }
      }
    }
    return true;
  }

  GameBoard spawnNextPiece() {
    if (nextPieces.isEmpty) return this;

    final nextType = nextPieces.first;
    final newPiece = Tetromino.create(nextType);
    final newNextPieces = List<AppConstants.TetrominoType>.from(nextPieces.skip(1));
    
    // 새로운 피스 추가
    if (newNextPieces.length < 5) {
      newNextPieces.add(TetrominoGenerator.getNext());
    }

    final ghost = _calculateGhostPieceForPiece(newPiece);

    return copyWith(
      currentPiece: newPiece,
      ghostPiece: ghost,
      nextPieces: newNextPieces,
      canHold: true,
    );
  }

  Tetromino? _calculateGhostPieceForPiece(Tetromino piece) {
    Tetromino ghost = piece.asGhost();
    
    while (isValidPosition(ghost.moveBy(0, 1))) {
      ghost = ghost.moveBy(0, 1);
    }
    
    return ghost;
  }

  GameBoard holdPiece() {
    if (!canHold || currentPiece == null) return this;

    if (heldPiece == null) {
      // 처음 홀드하는 경우
      return spawnNextPiece().copyWith(
        heldPiece: Tetromino.create(currentPiece!.type),
        canHold: false,
      );
    } else {
      // 홀드된 피스와 교체
      final newPiece = Tetromino.create(heldPiece!.type);
      final ghost = _calculateGhostPieceForPiece(newPiece);
      
      return copyWith(
        currentPiece: newPiece,
        ghostPiece: ghost,
        heldPiece: Tetromino.create(currentPiece!.type),
        canHold: false,
      );
    }
  }

  int getFallSpeed() {
    // 레벨에 따른 낙하 속도 계산 (밀리초)
    final baseSpeed = 1000;
    final speedDecrease = (level - 1) * 50;
    final minSpeed = 50;
    
    return (baseSpeed - speedDecrease).clamp(minSpeed, baseSpeed);
  }

  GameBoard updateCombo(int linesCleared) {
    final newCombo = linesCleared > 0 ? combo + 1 : 0;
    return copyWith(combo: newCombo);
  }

  GameBoard resetCombo() {
    return copyWith(combo: 0);
  }
}

// 게임 로직 헬퍼 클래스
class GameLogic {
  static MovementResult movePiece(GameBoard board, AppConstants.Direction direction) {
    if (board.currentPiece == null) {
      return const MovementResult(success: false);
    }

    Tetromino newPiece;
    switch (direction) {
      case AppConstants.Direction.left:
        newPiece = board.currentPiece!.moveBy(-1, 0);
        break;
      case AppConstants.Direction.right:
        newPiece = board.currentPiece!.moveBy(1, 0);
        break;
      case AppConstants.Direction.down:
        newPiece = board.currentPiece!.moveBy(0, 1);
        break;
    }

    if (board.isValidPosition(newPiece)) {
      return MovementResult(
        success: true,
        newPiece: newPiece,
      );
    }

    return const MovementResult(success: false);
  }

  static MovementResult rotatePiece(GameBoard board, AppConstants.RotationDirection direction) {
    if (board.currentPiece == null || !board.currentPiece!.canRotate) {
      return const MovementResult(success: false);
    }

    final piece = board.currentPiece!;
    Tetromino rotatedPiece;
    
    if (direction == AppConstants.RotationDirection.clockwise) {
      rotatedPiece = piece.rotate();
    } else {
      rotatedPiece = piece.rotateCounterClockwise();
    }

    // SRS 월킥 적용
    final wallKicks = SRSData.getWallKicks(piece.type, piece.rotation);
    
    for (final kick in wallKicks) {
      final testPiece = rotatedPiece.moveBy(kick.x, kick.y);
      if (board.isValidPosition(testPiece)) {
        return MovementResult(
          success: true,
          newPiece: testPiece,
        );
      }
    }

    return const MovementResult(success: false);
  }

  static MovementResult hardDrop(GameBoard board) {
    if (board.currentPiece == null) {
      return const MovementResult(success: false);
    }

    Tetromino piece = board.currentPiece!;
    int dropDistance = 0;

    // 최하단까지 이동
    while (board.isValidPosition(piece.moveBy(0, 1))) {
      piece = piece.moveBy(0, 1);
      dropDistance++;
    }

    final lockResult = lockPiece(board.copyWith(currentPiece: piece));
    
    return lockResult.copyWith(
      score: lockResult.score + (dropDistance * 2), // 하드 드롭 보너스
    );
  }

  static MovementResult lockPiece(GameBoard board) {
    if (board.currentPiece == null) {
      return const MovementResult(success: false);
    }

    final piece = board.currentPiece!;
    final boardWithPiece = board.placePiece(piece);
    final fullLines = boardWithPiece.getFullLines();
    
    // T-Spin 체크
    final isTSpin = TSpinDetector.isTSpin(piece, boardWithPiece.board.cast<List<bool?>>());
    
    // 라인 클리어
    final clearedBoard = boardWithPiece.clearLines(fullLines);
    
    // 퍼펙트 클리어 체크
    final isPerfectClear = clearedBoard.isPerfectClear();
    
    // 어택 라인 계산
    int attackLines = 0;
    if (fullLines.isNotEmpty) {
      attackLines = _calculateAttackLines(fullLines.length, isTSpin, isPerfectClear);
    }

    // 이벤트 타입 결정
    String? eventType;
    if (isPerfectClear) {
      eventType = 'perfect_clear';
    } else if (isTSpin && fullLines.isNotEmpty) {
      eventType = 't_spin';
    } else if (fullLines.length == 4) {
      eventType = 'tetris';
    } else if (fullLines.isNotEmpty) {
      eventType = 'line_clear';
    }

    return MovementResult(
      success: true,
      clearedLines: fullLines,
      score: clearedBoard.score - boardWithPiece.score,
      isTSpin: isTSpin,
      isPerfectClear: isPerfectClear,
      attackLines: attackLines,
      eventType: eventType,
    );
  }

  static int _calculateAttackLines(int linesCleared, bool isTSpin, bool isPerfectClear) {
    if (isPerfectClear) {
      return linesCleared == 4 ? 10 : linesCleared * 2;
    }
    
    if (isTSpin) {
      switch (linesCleared) {
        case 1: return 2;
        case 2: return 4;
        case 3: return 6;
        default: return 0;
      }
    }
    
    switch (linesCleared) {
      case 1: return 0;
      case 2: return 1;
      case 3: return 2;
      case 4: return 4; // 테트리스
      default: return 0;
    }
  }
}
