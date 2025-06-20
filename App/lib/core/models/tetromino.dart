import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../constants/app_constants.dart';

part 'tetromino.freezed.dart';
part 'tetromino.g.dart';

@freezed
class Tetromino with _$Tetromino {
  const factory Tetromino({
    required AppConstants.TetrominoType type,
    required List<List<bool>> shape,
    required Position position,
    @Default(0) int rotation,
    @Default(false) bool isLocked,
    @Default(false) bool isGhost,
  }) = _Tetromino;

  factory Tetromino.fromJson(Map<String, dynamic> json) => _$TetrominoFromJson(json);

  factory Tetromino.create(AppConstants.TetrominoType type) {
    return Tetromino(
      type: type,
      shape: _getInitialShape(type),
      position: const Position(x: 4, y: 0), // 보드 중앙 상단
      rotation: 0,
    );
  }

  static List<List<bool>> _getInitialShape(AppConstants.TetrominoType type) {
    switch (type) {
      case AppConstants.TetrominoType.I:
        return [
          [false, false, false, false],
          [true, true, true, true],
          [false, false, false, false],
          [false, false, false, false],
        ];
      case AppConstants.TetrominoType.O:
        return [
          [true, true],
          [true, true],
        ];
      case AppConstants.TetrominoType.T:
        return [
          [false, true, false],
          [true, true, true],
          [false, false, false],
        ];
      case AppConstants.TetrominoType.S:
        return [
          [false, true, true],
          [true, true, false],
          [false, false, false],
        ];
      case AppConstants.TetrominoType.Z:
        return [
          [true, true, false],
          [false, true, true],
          [false, false, false],
        ];
      case AppConstants.TetrominoType.J:
        return [
          [true, false, false],
          [true, true, true],
          [false, false, false],
        ];
      case AppConstants.TetrominoType.L:
        return [
          [false, false, true],
          [true, true, true],
          [false, false, false],
        ];
    }
  }
}

@freezed
class Position with _$Position {
  const factory Position({
    required int x,
    required int y,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
}

@freezed
class TetrominoQueue with _$TetrominoQueue {
  const factory TetrominoQueue({
    @Default([]) List<AppConstants.TetrominoType> upcoming,
    @Default([]) List<AppConstants.TetrominoType> bag,
  }) = _TetrominoQueue;

  factory TetrominoQueue.fromJson(Map<String, dynamic> json) => _$TetrominoQueueFromJson(json);
}

// SRS (Super Rotation System) 데이터
class SRSData {
  // 기본 회전 데이터 (I 피스 제외)
  static const Map<int, List<Position>> basicWallKicks = {
    0: [Position(x: 0, y: 0), Position(x: -1, y: 0), Position(x: -1, y: 1), Position(x: 0, y: -2), Position(x: -1, y: -2)],
    1: [Position(x: 0, y: 0), Position(x: 1, y: 0), Position(x: 1, y: -1), Position(x: 0, y: 2), Position(x: 1, y: 2)],
    2: [Position(x: 0, y: 0), Position(x: 1, y: 0), Position(x: 1, y: 1), Position(x: 0, y: -2), Position(x: 1, y: -2)],
    3: [Position(x: 0, y: 0), Position(x: -1, y: 0), Position(x: -1, y: -1), Position(x: 0, y: 2), Position(x: -1, y: 2)],
  };

  // I 피스 전용 회전 데이터
  static const Map<int, List<Position>> iWallKicks = {
    0: [Position(x: 0, y: 0), Position(x: -2, y: 0), Position(x: 1, y: 0), Position(x: -2, y: -1), Position(x: 1, y: 2)],
    1: [Position(x: 0, y: 0), Position(x: -1, y: 0), Position(x: 2, y: 0), Position(x: -1, y: 2), Position(x: 2, y: -1)],
    2: [Position(x: 0, y: 0), Position(x: 2, y: 0), Position(x: -1, y: 0), Position(x: 2, y: 1), Position(x: -1, y: -2)],
    3: [Position(x: 0, y: 0), Position(x: 1, y: 0), Position(x: -2, y: 0), Position(x: 1, y: -2), Position(x: -2, y: 1)],
  };

  static List<Position> getWallKicks(AppConstants.TetrominoType type, int fromRotation) {
    if (type == AppConstants.TetrominoType.I) {
      return iWallKicks[fromRotation] ?? [];
    } else if (type == AppConstants.TetrominoType.O) {
      return [const Position(x: 0, y: 0)]; // O 피스는 회전하지 않음
    } else {
      return basicWallKicks[fromRotation] ?? [];
    }
  }
}

// 확장 메서드들
extension TetrominoExtension on Tetromino {
  Color get color {
    return Color(AppConstants.tetrominoColors[type] ?? 0xFFFFFFFF);
  }

  Tetromino moveBy(int dx, int dy) {
    return copyWith(
      position: Position(
        x: position.x + dx,
        y: position.y + dy,
      ),
    );
  }

  Tetromino moveTo(int x, int y) {
    return copyWith(position: Position(x: x, y: y));
  }

  Tetromino rotate() {
    final newRotation = (rotation + 1) % 4;
    final rotatedShape = _rotateShape(shape);
    
    return copyWith(
      shape: rotatedShape,
      rotation: newRotation,
    );
  }

  Tetromino rotateCounterClockwise() {
    final newRotation = (rotation - 1 + 4) % 4;
    final rotatedShape = _rotateShapeCounterClockwise(shape);
    
    return copyWith(
      shape: rotatedShape,
      rotation: newRotation,
    );
  }

  List<List<bool>> _rotateShape(List<List<bool>> shape) {
    final rows = shape.length;
    final cols = shape[0].length;
    final rotated = List.generate(cols, (i) => List.generate(rows, (j) => false));

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        rotated[j][rows - 1 - i] = shape[i][j];
      }
    }

    return rotated;
  }

  List<List<bool>> _rotateShapeCounterClockwise(List<List<bool>> shape) {
    final rows = shape.length;
    final cols = shape[0].length;
    final rotated = List.generate(cols, (i) => List.generate(rows, (j) => false));

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        rotated[cols - 1 - j][i] = shape[i][j];
      }
    }

    return rotated;
  }

  Tetromino asGhost() {
    return copyWith(isGhost: true);
  }

  Tetromino lock() {
    return copyWith(isLocked: true);
  }

  List<Position> getBlockPositions() {
    final List<Position> positions = [];
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j]) {
          positions.add(Position(
            x: position.x + j,
            y: position.y + i,
          ));
        }
      }
    }
    return positions;
  }

  int get width => shape.isNotEmpty ? shape[0].length : 0;
  int get height => shape.length;

  bool get canRotate => type != AppConstants.TetrominoType.O;
}

extension PositionExtension on Position {
  Position moveBy(int dx, int dy) {
    return Position(x: x + dx, y: y + dy);
  }

  bool isValidPosition(int boardWidth, int boardHeight) {
    return x >= 0 && x < boardWidth && y >= 0 && y < boardHeight;
  }
}

// 테트로미노 생성기
class TetrominoGenerator {
  static List<AppConstants.TetrominoType> _bag = [];
  
  static AppConstants.TetrominoType getNext() {
    if (_bag.isEmpty) {
      _refillBag();
    }
    return _bag.removeAt(0);
  }

  static List<AppConstants.TetrominoType> getNextN(int count) {
    final List<AppConstants.TetrominoType> pieces = [];
    for (int i = 0; i < count; i++) {
      pieces.add(getNext());
    }
    return pieces;
  }

  static void _refillBag() {
    _bag = List.from(AppConstants.TetrominoType.values);
    _bag.shuffle();
  }

  static void reset() {
    _bag.clear();
  }
}

// T-Spin 감지를 위한 헬퍼
class TSpinDetector {
  static bool isTSpin(Tetromino tetromino, List<List<bool?>> board) {
    if (tetromino.type != AppConstants.TetrominoType.T) return false;

    final pos = tetromino.position;
    final corners = [
      Position(x: pos.x, y: pos.y),         // 왼쪽 상단
      Position(x: pos.x + 2, y: pos.y),     // 오른쪽 상단
      Position(x: pos.x, y: pos.y + 2),     // 왼쪽 하단
      Position(x: pos.x + 2, y: pos.y + 2), // 오른쪽 하단
    ];

    int filledCorners = 0;
    for (final corner in corners) {
      if (corner.x < 0 || corner.x >= AppConstants.boardWidth ||
          corner.y < 0 || corner.y >= AppConstants.boardHeight ||
          (corner.y < board.length && corner.x < board[corner.y].length && 
           board[corner.y][corner.x] != null)) {
        filledCorners++;
      }
    }

    return filledCorners >= 3;
  }
}
