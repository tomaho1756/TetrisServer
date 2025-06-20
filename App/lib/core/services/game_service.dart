import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import '../models/game_board.dart';
import '../models/tetromino.dart';
import 'audio_service.dart';
import 'storage_service.dart';

// GameSession 클래스 정의 (GameBloc에서 사용)
class GameSession {
  final String id;
  final GameBoard board;
  final Tetromino? currentPiece;
  final List<AppConstants.TetrominoType> nextPieces;
  final Tetromino? heldPiece;
  final int score;
  final int level;
  final int linesCleared;
  final bool isGameOver;
  final bool isPaused;
  final DateTime startTime;

  const GameSession({
    required this.id,
    required this.board,
    this.currentPiece,
    required this.nextPieces,
    this.heldPiece,
    required this.score,
    required this.level,
    required this.linesCleared,
    required this.isGameOver,
    required this.isPaused,
    required this.startTime,
  });

  GameSession copyWith({
    String? id,
    GameBoard? board,
    Tetromino? currentPiece,
    List<AppConstants.TetrominoType>? nextPieces,
    Tetromino? heldPiece,
    int? score,
    int? level,
    int? linesCleared,
    bool? isGameOver,
    bool? isPaused,
    DateTime? startTime,
  }) {
    return GameSession(
      id: id ?? this.id,
      board: board ?? this.board,
      currentPiece: currentPiece ?? this.currentPiece,
      nextPieces: nextPieces ?? this.nextPieces,
      heldPiece: heldPiece ?? this.heldPiece,
      score: score ?? this.score,
      level: level ?? this.level,
      linesCleared: linesCleared ?? this.linesCleared,
      isGameOver: isGameOver ?? this.isGameOver,
      isPaused: isPaused ?? this.isPaused,
      startTime: startTime ?? this.startTime,
    );
  }
}

class GameService {
  static final GameService instance = GameService._internal();
  GameService._internal() {
    _initializeDio();
  }

  late final Dio _dio;
  final Map<String, GameSession> _activeSessions = {};
  Timer? _gameTimer;

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl + AppConstants.apiPrefix,
      connectTimeout: AppConstants.connectionTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // 토큰 인터셉터 추가
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await StorageService.instance.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));
  }

  // 싱글플레이어 게임 시작 (GameBloc에서 사용)
  Future<GameSession> startSingleGame() async {
    try {
      // 서버에 게임 시작 요청
      final response = await _dio.post('/game/start', data: {
        'mode': 'single',
        'difficulty': 'normal',
      });

      final gameId = response.data['game_id'] ?? _generateGameId();
      
      // 로컬 게임 세션 생성
      final gameSession = _createNewGameSession(gameId);
      _activeSessions[gameId] = gameSession;

      // 게임 타이머 시작
      _startGameTimer(gameId);

      await AudioService.instance.playGameStartSequence();
      
      return gameSession;
    } catch (e) {
      print('Start game error: $e');
      // 오프라인 모드로 게임 시작
      final gameId = _generateGameId();
      final gameSession = _createNewGameSession(gameId);
      _activeSessions[gameId] = gameSession;
      _startGameTimer(gameId);
      return gameSession;
    }
  }

  // 피스 이동 (GameBloc에서 사용)
  Future<GameSession> movePiece(String gameId, String direction) async {
    final session = _activeSessions[gameId];
    if (session == null || session.isGameOver || session.isPaused) {
      throw Exception('Game not active');
    }

    final currentBoard = session.board;
    if (currentBoard.currentPiece == null) {
      return session;
    }

    AppConstants.Direction dir;
    switch (direction.toLowerCase()) {
      case 'left':
        dir = AppConstants.Direction.left;
        break;
      case 'right':
        dir = AppConstants.Direction.right;
        break;
      case 'down':
        dir = AppConstants.Direction.down;
        break;
      default:
        return session;
    }

    final moveResult = GameLogic.movePiece(currentBoard, dir);
    
    if (moveResult.success && moveResult.newPiece != null) {
      await AudioService.instance.playSoundEffect(SoundEffect.move);
      
      final updatedBoard = currentBoard.copyWith(
        currentPiece: moveResult.newPiece,
        ghostPiece: currentBoard.calculateGhostPiece(),
      );

      final updatedSession = session.copyWith(board: updatedBoard);
      _activeSessions[gameId] = updatedSession;
      
      // 서버에 이동 전송 (필요한 경우)
      _sendMoveToServer(gameId, {
        'type': 'move',
        'direction': direction,
        'piece_position': {
          'x': moveResult.newPiece!.position.x,
          'y': moveResult.newPiece!.position.y,
        }
      });

      return updatedSession;
    }

    return session;
  }

  // 피스 회전 (GameBloc에서 사용)
  Future<GameSession> rotatePiece(String gameId, bool clockwise) async {
    final session = _activeSessions[gameId];
    if (session == null || session.isGameOver || session.isPaused) {
      throw Exception('Game not active');
    }

    final currentBoard = session.board;
    if (currentBoard.currentPiece == null) {
      return session;
    }

    final rotationDirection = clockwise 
        ? AppConstants.RotationDirection.clockwise 
        : AppConstants.RotationDirection.counterclockwise;

    final rotateResult = GameLogic.rotatePiece(currentBoard, rotationDirection);
    
    if (rotateResult.success && rotateResult.newPiece != null) {
      await AudioService.instance.playSoundEffect(SoundEffect.rotate);
      
      final updatedBoard = currentBoard.copyWith(
        currentPiece: rotateResult.newPiece,
        ghostPiece: currentBoard.calculateGhostPiece(),
      );

      final updatedSession = session.copyWith(board: updatedBoard);
      _activeSessions[gameId] = updatedSession;

      return updatedSession;
    }

    return session;
  }

  // 피스 하드 드롭 (GameBloc에서 사용)
  Future<GameSession> dropPiece(String gameId) async {
    final session = _activeSessions[gameId];
    if (session == null || session.isGameOver || session.isPaused) {
      throw Exception('Game not active');
    }

    final currentBoard = session.board;
    if (currentBoard.currentPiece == null) {
      return session;
    }

    final dropResult = GameLogic.hardDrop(currentBoard);
    await AudioService.instance.playSoundEffect(SoundEffect.drop);

    if (dropResult.clearedLines.isNotEmpty) {
      await AudioService.instance.playLineClearSequence(dropResult.clearedLines.length);
    }

    // 라인 클리어 후 새 피스 생성
    final boardAfterClear = currentBoard.clearLines(dropResult.clearedLines);
    final finalBoard = boardAfterClear.spawnNextPiece();

    // 게임 오버 체크
    final isGameOver = finalBoard.isGameOver();
    if (isGameOver) {
      await AudioService.instance.playGameOverSequence();
      await _endGame(gameId, session.copyWith(isGameOver: true));
    }

    final updatedSession = session.copyWith(
      board: finalBoard,
      score: session.score + dropResult.score,
      linesCleared: session.linesCleared + dropResult.clearedLines.length,
      level: _calculateLevel(session.linesCleared + dropResult.clearedLines.length),
      isGameOver: isGameOver,
    );

    _activeSessions[gameId] = updatedSession;
    return updatedSession;
  }

  // 피스 홀드 (GameBloc에서 사용)
  Future<GameSession> holdPiece(String gameId) async {
    final session = _activeSessions[gameId];
    if (session == null || session.isGameOver || session.isPaused) {
      throw Exception('Game not active');
    }

    final currentBoard = session.board;
    final boardWithHold = currentBoard.holdPiece();

    await AudioService.instance.playSoundEffect(SoundEffect.hold);

    final updatedSession = session.copyWith(board: boardWithHold);
    _activeSessions[gameId] = updatedSession;

    return updatedSession;
  }

  // 게임 종료 (GameBloc에서 사용)
  Future<void> endGame(String gameId) async {
    final session = _activeSessions[gameId];
    if (session == null) return;

    await _endGame(gameId, session.copyWith(isGameOver: true));
  }

  // 게임 일시정지/재개
  Future<GameSession> pauseGame(String gameId) async {
    final session = _activeSessions[gameId];
    if (session == null) throw Exception('Game not found');

    final updatedSession = session.copyWith(isPaused: !session.isPaused);
    _activeSessions[gameId] = updatedSession;

    if (updatedSession.isPaused) {
      _gameTimer?.cancel();
      await AudioService.instance.pauseBackgroundMusic();
    } else {
      _startGameTimer(gameId);
      await AudioService.instance.resumeBackgroundMusic();
    }

    return updatedSession;
  }

  // 멀티플레이어 게임 참가
  Future<GameSession> joinMultiplayerGame(String gameId) async {
    try {
      final response = await _dio.post('/game/$gameId/join');
      // 서버 응답을 바탕으로 게임 세션 생성
      return _createGameSessionFromServerData(gameId, response.data);
    } catch (e) {
      throw Exception('Failed to join game: $e');
    }
  }

  // 게임 상태 가져오기
  Future<GameSession?> getGameSession(String gameId) async {
    return _activeSessions[gameId];
  }

  // 활성 게임 세션들
  List<GameSession> get activeSessions => _activeSessions.values.toList();

  // Private 메서드들
  String _generateGameId() {
    return 'game_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';
  }

  GameSession _createNewGameSession(String gameId) {
    final board = GameBoard.empty().spawnNextPiece();
    
    return GameSession(
      id: gameId,
      board: board,
      currentPiece: board.currentPiece,
      nextPieces: board.nextPieces,
      heldPiece: null,
      score: 0,
      level: 1,
      linesCleared: 0,
      isGameOver: false,
      isPaused: false,
      startTime: DateTime.now(),
    );
  }

  GameSession _createGameSessionFromServerData(String gameId, Map<String, dynamic> data) {
    // 서버 데이터로부터 게임 세션 생성
    return GameSession(
      id: gameId,
      board: GameBoard.empty(), // 실제로는 서버 데이터를 파싱
      currentPiece: null,
      nextPieces: [],
      heldPiece: null,
      score: data['score'] ?? 0,
      level: data['level'] ?? 1,
      linesCleared: data['lines_cleared'] ?? 0,
      isGameOver: data['is_game_over'] ?? false,
      isPaused: data['is_paused'] ?? false,
      startTime: DateTime.now(),
    );
  }

  void _startGameTimer(String gameId) {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      _handleGameTick(gameId);
    });
  }

  void _handleGameTick(String gameId) {
    final session = _activeSessions[gameId];
    if (session == null || session.isGameOver || session.isPaused) {
      return;
    }

    // 자동 낙하 처리
    movePiece(gameId, 'down').catchError((e) {
      print('Auto fall error: $e');
    });
  }

  int _calculateLevel(int linesCleared) {
    return (linesCleared ~/ AppConstants.linesPerLevel) + 1;
  }

  Future<void> _endGame(String gameId, GameSession session) async {
    _gameTimer?.cancel();
    _activeSessions[gameId] = session;

    // 서버에 게임 결과 전송
    try {
      await _dio.post('/game/$gameId/end', data: {
        'score': session.score,
        'level': session.level,
        'lines_cleared': session.linesCleared,
        'duration': DateTime.now().difference(session.startTime).inSeconds,
      });
    } catch (e) {
      print('End game server error: $e');
    }

    // 로컬 저장소에 게임 기록 저장
    await _saveGameRecord(session);

    // 일정 시간 후 세션 정리
    Timer(const Duration(minutes: 5), () {
      _activeSessions.remove(gameId);
    });
  }

  Future<void> _saveGameRecord(GameSession session) async {
    final record = {
      'id': session.id,
      'score': session.score,
      'level': session.level,
      'lines_cleared': session.linesCleared,
      'duration': DateTime.now().difference(session.startTime).inSeconds,
      'played_at': session.startTime.toIso8601String(),
      'game_mode': 'single',
    };

    await StorageService.instance.saveGameRecord(record);

    // 최고 점수 업데이트
    final currentHigh = await StorageService.instance.getHighScore();
    if (session.score > currentHigh) {
      await StorageService.instance.saveHighScore(session.score);
    }
  }

  Future<void> _sendMoveToServer(String gameId, Map<String, dynamic> moveData) async {
    try {
      await _dio.post('/game/$gameId/move', data: moveData);
    } catch (e) {
      print('Send move error: $e');
    }
  }

  // 리소스 정리
  void dispose() {
    _gameTimer?.cancel();
    _activeSessions.clear();
  }
}
