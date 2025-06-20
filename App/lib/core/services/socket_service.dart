import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../constants/app_constants.dart';
import 'storage_service.dart';

class SocketService {
  static SocketService? _instance;
  static SocketService get instance => _instance ??= SocketService._();
  
  SocketService._();

  IO.Socket? _socket;
  bool _isConnected = false;
  String? _currentRoomId;
  String? _currentGameId;
  
  // 이벤트 스트림 컨트롤러들
  final StreamController<Map<String, dynamic>> _gameStateController = StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _roomStateController = StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _chatController = StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _matchmakingController = StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _userStatusController = StreamController.broadcast();
  final StreamController<bool> _connectionController = StreamController.broadcast();

  // 스트림 getters
  Stream<Map<String, dynamic>> get gameStateStream => _gameStateController.stream;
  Stream<Map<String, dynamic>> get roomStateStream => _roomStateController.stream;
  Stream<Map<String, dynamic>> get chatStream => _chatController.stream;
  Stream<Map<String, dynamic>> get matchmakingStream => _matchmakingController.stream;
  Stream<Map<String, dynamic>> get userStatusStream => _userStatusController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;

  // 연결 상태
  bool get isConnected => _isConnected;
  String? get currentRoomId => _currentRoomId;
  String? get currentGameId => _currentGameId;

  // 연결
  Future<void> connect() async {
    if (_socket != null && _isConnected) {
      print('Socket already connected');
      return;
    }

    try {
      final token = StorageService.instance.getAuthToken();
      
      _socket = IO.io(AppConstants.socketUrl, 
        IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setAuth({
            'token': token,
          })
          .build()
      );

      _setupEventHandlers();
      
      _socket!.connect();
      
      // 연결 타임아웃 설정
      Timer(const Duration(seconds: 10), () {
        if (!_isConnected) {
          print('Socket connection timeout');
          _connectionController.add(false);
        }
      });

    } catch (e) {
      print('Socket connection error: $e');
      _connectionController.add(false);
    }
  }

  // 연결 해제
  Future<void> disconnect() async {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
    }
    _isConnected = false;
    _currentRoomId = null;
    _currentGameId = null;
    _connectionController.add(false);
  }

  // 이벤트 핸들러 설정
  void _setupEventHandlers() {
    if (_socket == null) return;

    // 연결 관련
    _socket!.onConnect((_) {
      print('Socket connected');
      _isConnected = true;
      _connectionController.add(true);
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
      _isConnected = false;
      _connectionController.add(false);
    });

    _socket!.onConnectError((error) {
      print('Socket connection error: $error');
      _isConnected = false;
      _connectionController.add(false);
    });

    // 게임 관련 이벤트
    _socket!.on('game_state_update', (data) {
      _gameStateController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('player_move', (data) {
      _gameStateController.add({
        'type': 'player_move',
        'data': data,
      });
    });

    _socket!.on('game_started', (data) {
      _currentGameId = data['game_id'];
      _gameStateController.add({
        'type': 'game_started',
        'data': data,
      });
    });

    _socket!.on('game_ended', (data) {
      _gameStateController.add({
        'type': 'game_ended',
        'data': data,
      });
      _currentGameId = null;
    });

    _socket!.on('player_joined_game', (data) {
      _gameStateController.add({
        'type': 'player_joined',
        'data': data,
      });
    });

    _socket!.on('player_left_game', (data) {
      _gameStateController.add({
        'type': 'player_left',
        'data': data,
      });
    });

    _socket!.on('attack_received', (data) {
      _gameStateController.add({
        'type': 'attack_received',
        'data': data,
      });
    });

    // 방 관련 이벤트
    _socket!.on('room_state_update', (data) {
      _roomStateController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('room_joined', (data) {
      _currentRoomId = data['room_id'];
      _roomStateController.add({
        'type': 'room_joined',
        'data': data,
      });
    });

    _socket!.on('room_left', (data) {
      _roomStateController.add({
        'type': 'room_left',
        'data': data,
      });
      _currentRoomId = null;
    });

    _socket!.on('player_joined_room', (data) {
      _roomStateController.add({
        'type': 'player_joined',
        'data': data,
      });
    });

    _socket!.on('player_left_room', (data) {
      _roomStateController.add({
        'type': 'player_left',
        'data': data,
      });
    });

    _socket!.on('room_settings_changed', (data) {
      _roomStateController.add({
        'type': 'settings_changed',
        'data': data,
      });
    });

    // 채팅 관련 이벤트
    _socket!.on('chat_message', (data) {
      _chatController.add({
        'type': 'message',
        'data': data,
      });
    });

    _socket!.on('system_message', (data) {
      _chatController.add({
        'type': 'system',
        'data': data,
      });
    });

    // 매칭 관련 이벤트
    _socket!.on('match_found', (data) {
      _matchmakingController.add({
        'type': 'match_found',
        'data': data,
      });
    });

    _socket!.on('matchmaking_update', (data) {
      _matchmakingController.add({
        'type': 'update',
        'data': data,
      });
    });

    _socket!.on('matchmaking_cancelled', (data) {
      _matchmakingController.add({
        'type': 'cancelled',
        'data': data,
      });
    });

    // 사용자 상태 이벤트
    _socket!.on('user_status_update', (data) {
      _userStatusController.add(Map<String, dynamic>.from(data));
    });

    // 에러 처리
    _socket!.on('error', (error) {
      print('Socket error: $error');
    });
  }

  // 게임 관련 이벤트 전송
  Future<void> sendMove({
    required String gameId,
    required Map<String, dynamic> moveData,
  }) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('player_move', {
      'game_id': gameId,
      'move_data': moveData,
    });
  }

  Future<void> sendAttack({
    required String gameId,
    required int lines,
    String? targetPlayerId,
  }) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('send_attack', {
      'game_id': gameId,
      'lines': lines,
      'target_player_id': targetPlayerId,
    });
  }

  Future<void> joinGame(String gameId) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('join_game', {'game_id': gameId});
  }

  Future<void> leaveGame(String gameId) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('leave_game', {'game_id': gameId});
    _currentGameId = null;
  }

  Future<void> pauseGame(String gameId) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('pause_game', {'game_id': gameId});
  }

  Future<void> resumeGame(String gameId) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('resume_game', {'game_id': gameId});
  }

  // 방 관련 이벤트 전송
  Future<void> joinRoom(String roomId, {String? password}) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('join_room', {
      'room_id': roomId,
      'password': password,
    });
  }

  Future<void> leaveRoom(String roomId) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('leave_room', {'room_id': roomId});
    _currentRoomId = null;
  }

  Future<void> startRoomGame(String roomId) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('start_room_game', {'room_id': roomId});
  }

  Future<void> updateRoomSettings({
    required String roomId,
    required Map<String, dynamic> settings,
  }) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('update_room_settings', {
      'room_id': roomId,
      'settings': settings,
    });
  }

  // 채팅 관련
  Future<void> sendChatMessage({
    required String roomId,
    required String message,
  }) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('chat_message', {
      'room_id': roomId,
      'message': message,
    });
  }

  // 매칭 관련
  Future<void> startMatchmaking({
    required String gameMode,
    String? skillLevel,
  }) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('start_matchmaking', {
      'game_mode': gameMode,
      'skill_level': skillLevel,
    });
  }

  Future<void> cancelMatchmaking() async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('cancel_matchmaking');
  }

  // 사용자 상태 업데이트
  Future<void> updateUserStatus(String status) async {
    if (!_isConnected || _socket == null) return;
    
    _socket!.emit('update_status', {'status': status});
  }

  // 하트비트 (연결 유지)
  void startHeartbeat() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_isConnected && _socket != null) {
        _socket!.emit('ping');
      } else {
        timer.cancel();
      }
    });
  }

  // 재연결 시도
  Future<void> reconnect() async {
    await disconnect();
    await Future.delayed(const Duration(seconds: 1));
    await connect();
  }

  // 이벤트 리스너 등록/해제
  void addEventListener(String event, void Function(dynamic) handler) {
    _socket?.on(event, handler);
  }

  void removeEventListener(String event) {
    _socket?.off(event);
  }

  // 커스텀 이벤트 전송
  void emit(String event, [dynamic data]) {
    if (_isConnected && _socket != null) {
      _socket!.emit(event, data);
    }
  }

  // 리소스 해제
  void dispose() {
    _gameStateController.close();
    _roomStateController.close();
    _chatController.close();
    _matchmakingController.close();
    _userStatusController.close();
    _connectionController.close();
    disconnect();
  }
}

// Socket 이벤트 타입 정의
class SocketEvents {
  // 게임 이벤트
  static const String gameStateUpdate = 'game_state_update';
  static const String playerMove = 'player_move';
  static const String gameStarted = 'game_started';
  static const String gameEnded = 'game_ended';
  static const String attackReceived = 'attack_received';
  
  // 방 이벤트
  static const String roomJoined = 'room_joined';
  static const String roomLeft = 'room_left';
  static const String roomStateUpdate = 'room_state_update';
  
  // 채팅 이벤트
  static const String chatMessage = 'chat_message';
  static const String systemMessage = 'system_message';
  
  // 매칭 이벤트
  static const String matchFound = 'match_found';
  static const String matchmakingUpdate = 'matchmaking_update';
  
  // 연결 이벤트
  static const String connect = 'connect';
  static const String disconnect = 'disconnect';
  static const String error = 'error';
}

// Socket 상태 관리 헬퍼
class SocketConnectionManager {
  static const int maxReconnectAttempts = 5;
  static const Duration reconnectDelay = Duration(seconds: 2);
  
  static Future<bool> ensureConnection() async {
    final socket = SocketService.instance;
    
    if (socket.isConnected) {
      return true;
    }
    
    int attempts = 0;
    while (attempts < maxReconnectAttempts) {
      try {
        await socket.connect();
        
        // 연결 확인을 위해 잠시 대기
        await Future.delayed(const Duration(seconds: 1));
        
        if (socket.isConnected) {
          return true;
        }
      } catch (e) {
        print('Reconnection attempt ${attempts + 1} failed: $e');
      }
      
      attempts++;
      if (attempts < maxReconnectAttempts) {
        await Future.delayed(reconnectDelay);
      }
    }
    
    return false;
  }
}
