import 'dart:ui';

class GameConstants {
  // 게임 보드 크기
  static const int boardWidth = 10;
  static const int boardHeight = 20;
  static const int previewAreaHeight = 4;
  
  // 블록 크기
  static const double blockSize = 30.0;
  static const double previewBlockSize = 20.0;
  
  // 게임 속도 (밀리초)
  static const Map<int, int> levelSpeeds = {
    1: 1000,
    2: 900,
    3: 800,
    4: 700,
    5: 600,
    6: 500,
    7: 400,
    8: 300,
    9: 200,
    10: 100,
  };
  
  // 점수 계산
  static const Map<int, int> lineScores = {
    1: 100,
    2: 300,
    3: 500,
    4: 800, // 테트리스
  };
  
  static const int softDropScore = 1;
  static const int hardDropScore = 2;
  
  // 레벨업 조건
  static const int linesPerLevel = 10;
  
  // 테트로미노 타입
  enum TetrominoType {
    I, O, T, S, Z, J, L
  }
  
  // 테트로미노 색상
  static const Map<TetrominoType, Color> tetrominoColors = {
    TetrominoType.I: Color(0xFF00FFFF), // 시안
    TetrominoType.O: Color(0xFFFFFF00), // 노랑
    TetrominoType.T: Color(0xFF800080), // 보라
    TetrominoType.S: Color(0xFF00FF00), // 초록
    TetrominoType.Z: Color(0xFFFF0000), // 빨강
    TetrominoType.J: Color(0xFF0000FF), // 파랑
    TetrominoType.L: Color(0xFFFFA500), // 주황
  };
  
  // 테트로미노 모양 (회전 상태별)
  static const Map<TetrominoType, List<List<List<int>>>> tetrominoShapes = {
    TetrominoType.I: [
      [[0,0,0,0], [1,1,1,1], [0,0,0,0], [0,0,0,0]],
      [[0,0,1,0], [0,0,1,0], [0,0,1,0], [0,0,1,0]],
    ],
    TetrominoType.O: [
      [[1,1], [1,1]],
    ],
    TetrominoType.T: [
      [[0,1,0], [1,1,1], [0,0,0]],
      [[0,1,0], [0,1,1], [0,1,0]],
      [[0,0,0], [1,1,1], [0,1,0]],
      [[0,1,0], [1,1,0], [0,1,0]],
    ],
    TetrominoType.S: [
      [[0,1,1], [1,1,0], [0,0,0]],
      [[0,1,0], [0,1,1], [0,0,1]],
    ],
    TetrominoType.Z: [
      [[1,1,0], [0,1,1], [0,0,0]],
      [[0,0,1], [0,1,1], [0,1,0]],
    ],
    TetrominoType.J: [
      [[1,0,0], [1,1,1], [0,0,0]],
      [[0,1,1], [0,1,0], [0,1,0]],
      [[0,0,0], [1,1,1], [0,0,1]],
      [[0,1,0], [0,1,0], [1,1,0]],
    ],
    TetrominoType.L: [
      [[0,0,1], [1,1,1], [0,0,0]],
      [[0,1,0], [0,1,0], [0,1,1]],
      [[0,0,0], [1,1,1], [1,0,0]],
      [[1,1,0], [0,1,0], [0,1,0]],
    ],
  };
  
  // 다음 블록 큐 크기
  static const int nextPieceQueueSize = 3;
  
  // 멀티플레이어 상수
  static const int maxPlayersPerRoom = 4;
  static const int minPlayersToStart = 2;
  
  // 애니메이션 지속시간
  static const Duration blockDropAnimation = Duration(milliseconds: 150);
  static const Duration lineClearAnimation = Duration(milliseconds: 300);
  static const Duration gameOverAnimation = Duration(milliseconds: 500);
}
