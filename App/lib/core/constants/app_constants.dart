// 게임 모드
enum GameMode {
  single,
  versus,
  team,
  practice,
}

// 테트로미노 타입
enum TetrominoType {
  I, O, T, S, Z, J, L
}

// 방향
enum Direction {
  left, right, down
}

// 회전 방향
enum RotationDirection {
  clockwise, counterclockwise
}

// 게임 상태
enum GameStatus {
  waiting,
  playing,
  paused,
  gameOver,
  completed,
}

// 매칭 타입
enum MatchType {
  quick,
  ranked,
  custom,
}

// 채팅 메시지 타입
enum MessageType {
  text,
  system,
  gameAction,
}

// 업적 타입
enum AchievementType {
  firstGame,
  firstWin,
  firstTetris,
  speedRunner,
  linesMaster,
  comboKing,
}

class AppConstants {
  // API 관련
  static const String baseUrl = 'http://localhost:8080';
  static const String apiPrefix = '/api';
  
  // WebSocket
  static const String socketUrl = 'ws://localhost:8080';
  
  // 게임 설정
  static const int boardWidth = 10;
  static const int boardHeight = 20;
  static const int previewRows = 4;
  
  // 타이밍 (밀리초)
  static const Map<String, int> fallSpeeds = {
    'easy': 1000,
    'normal': 800,
    'hard': 400,
    'expert': 200,
  };
  
  // 점수 시스템
  static const Map<int, int> lineScores = {
    1: 100,
    2: 300,
    3: 500,
    4: 800, // 테트리스
  };
  
  // 레벨별 줄 수
  static const int linesPerLevel = 10;
  
  // 애니메이션 시간
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  
  // 로컬 저장소 키
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String settingsKey = 'app_settings';
  static const String highScoreKey = 'high_score';
  static const String statisticsKey = 'statistics';
  
  // 사운드 파일
  static const Map<String, String> soundFiles = {
    'move': 'assets/audio/move.wav',
    'rotate': 'assets/audio/rotate.wav',
    'drop': 'assets/audio/drop.wav',
    'lineClear': 'assets/audio/line_clear.wav',
    'tetris': 'assets/audio/tetris.wav',
    'gameOver': 'assets/audio/game_over.wav',
    'levelUp': 'assets/audio/level_up.wav',
    'background': 'assets/audio/background.mp3',
  };
  
  // 네트워크 설정
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  
  // 색상 (16진수)
  static const Map<TetrominoType, int> tetrominoColors = {
    TetrominoType.I: 0xFF00FFFF, // 시안
    TetrominoType.O: 0xFFFFFF00, // 노랑
    TetrominoType.T: 0xFF800080, // 보라
    TetrominoType.S: 0xFF00FF00, // 초록
    TetrominoType.Z: 0xFFFF0000, // 빨강
    TetrominoType.J: 0xFF0000FF, // 파랑
    TetrominoType.L: 0xFFFFA500, // 주황
  };
  
  // 진동 패턴 (밀리초)
  static const List<int> vibrationPatterns = [100, 50, 100];
  static const List<int> strongVibrationPatterns = [200, 100, 200, 100, 200];
  
  // 정규표현식
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String usernameRegex = r'^[a-zA-Z0-9_]{3,20}$';
  static const String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';
  
  // 에러 메시지
  static const Map<String, String> errorMessages = {
    'network_error': '네트워크 연결을 확인해주세요',
    'server_error': '서버 오류가 발생했습니다',
    'invalid_credentials': '이메일 또는 비밀번호가 잘못되었습니다',
    'user_exists': '이미 존재하는 사용자입니다',
    'game_not_found': '게임을 찾을 수 없습니다',
    'room_full': '방이 가득 찼습니다',
    'room_not_found': '방을 찾을 수 없습니다',
    'invalid_move': '유효하지 않은 움직임입니다',
    'connection_lost': '연결이 끊어졌습니다',
  };
  
  // 성공 메시지
  static const Map<String, String> successMessages = {
    'login_success': '로그인 성공!',
    'register_success': '회원가입이 완료되었습니다!',
    'game_created': '게임이 생성되었습니다',
    'room_joined': '방에 참가했습니다',
    'settings_saved': '설정이 저장되었습니다',
  };
}
