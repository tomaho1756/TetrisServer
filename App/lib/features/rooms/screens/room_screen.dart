import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/bloc/auth_bloc.dart';

class RoomScreen extends StatefulWidget {
  final String roomId;
  
  const RoomScreen({
    super.key,
    required this.roomId,
  });

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final TextEditingController _chatController = TextEditingController();
  
  // 임시 데이터
  final RoomInfo _roomInfo = RoomInfo(
    id: 'room1',
    name: '빠른 대전방',
    mode: 'classic',
    maxPlayers: 4,
    isPrivate: false,
    host: 'SpeedMaster',
    status: 'waiting',
  );
  
  final List<RoomPlayer> _players = [
    RoomPlayer(
      id: '1',
      username: 'SpeedMaster',
      isHost: true,
      isReady: true,
      isOnline: true,
    ),
    RoomPlayer(
      id: '2',
      username: 'Player2',
      isHost: false,
      isReady: false,
      isOnline: true,
    ),
    RoomPlayer(
      id: '3',
      username: 'Player3',
      isHost: false,
      isReady: true,
      isOnline: true,
    ),
  ];
  
  final List<ChatMessage> _chatMessages = [
    ChatMessage(
      sender: 'SpeedMaster',
      message: '방에 오신 것을 환영합니다!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      isSystem: false,
    ),
    ChatMessage(
      sender: 'System',
      message: 'Player2님이 입장하셨습니다.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      isSystem: true,
    ),
    ChatMessage(
      sender: 'Player2',
      message: '안녕하세요!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      isSystem: false,
    ),
  ];
  
  bool _isReady = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return authState.maybeWhen(
          authenticated: (user) => Scaffold(
            appBar: AppBar(
              title: Text(_roomInfo.name),
              actions: [
                if (_isHost(user.username))
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: _showRoomSettings,
                  ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: _showRoomInfo,
                ),
              ],
            ),
            body: Column(
              children: [
                // 방 정보 헤더
                Container(
                  padding: const EdgeInsets.all(16),
                  color: theme.colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getModeIcon(_roomInfo.mode),
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _getModeDisplayName(_roomInfo.mode),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_players.length}/${_roomInfo.maxPlayers}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '방장: ${_roomInfo.host}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 메인 컨텐츠
                Expanded(
                  child: Row(
                    children: [
                      // 플레이어 목록
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]!),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.people),
                                    const SizedBox(width: 8),
                                    Text(
                                      '플레이어',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _roomInfo.maxPlayers,
                                  itemBuilder: (context, index) {
                                    if (index < _players.length) {
                                      final player = _players[index];
                                      return _PlayerTile(
                                        player: player,
                                        currentUser: user.username,
                                        onKick: _isHost(user.username) && !player.isHost
                                            ? () => _kickPlayer(player)
                                            : null,
                                      );
                                    } else {
                                      return _EmptyPlayerSlot(index: index + 1);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // 채팅
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[300]!),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.chat),
                                  const SizedBox(width: 8),
                                  Text(
                                    '채팅',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: _chatMessages.length,
                                itemBuilder: (context, index) {
                                  final message = _chatMessages[index];
                                  return _ChatMessageTile(message: message);
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.grey[300]!),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _chatController,
                                      decoration: const InputDecoration(
                                        hintText: '메시지 입력...',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                      onSubmitted: (value) => _sendMessage(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: _sendMessage,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 하단 버튼들
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      // 나가기 버튼
                      TextButton.icon(
                        onPressed: _leaveRoom,
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text('나가기'),
                      ),
                      
                      const Spacer(),
                      
                      // 준비/시작 버튼
                      if (_isHost(user.username))
                        ElevatedButton.icon(
                          onPressed: _canStartGame() ? _startGame : null,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('게임 시작'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        )
                      else
                        ElevatedButton.icon(
                          onPressed: _toggleReady,
                          icon: Icon(_isReady ? Icons.check : Icons.hourglass_empty),
                          label: Text(_isReady ? '준비완료' : '준비하기'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isReady 
                                ? Colors.green 
                                : theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          orElse: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
  
  bool _isHost(String username) {
    return username == _roomInfo.host;
  }
  
  bool _canStartGame() {
    return _players.length >= 2 && 
           _players.where((p) => !p.isHost).every((p) => p.isReady);
  }
  
  void _toggleReady() {
    setState(() {
      _isReady = !_isReady;
      // TODO: 서버에 준비 상태 전송
    });
  }
  
  void _startGame() {
    // TODO: 게임 시작 로직
    context.go('/game/multiplayer/${widget.roomId}');
  }
  
  void _leaveRoom() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('방 나가기'),
        content: const Text('정말로 방을 나가시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/rooms');
            },
            child: const Text('나가기'),
          ),
        ],
      ),
    );
  }
  
  void _kickPlayer(RoomPlayer player) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('플레이어 추방'),
        content: Text('${player.username}님을 추방하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _players.removeWhere((p) => p.id == player.id);
              });
              // TODO: 서버에 추방 요청
            },
            child: const Text('추방'),
          ),
        ],
      ),
    );
  }
  
  void _sendMessage() {
    if (_chatController.text.trim().isNotEmpty) {
      setState(() {
        _chatMessages.add(ChatMessage(
          sender: 'You', // 실제로는 현재 사용자 이름
          message: _chatController.text.trim(),
          timestamp: DateTime.now(),
          isSystem: false,
        ));
      });
      _chatController.clear();
      // TODO: 서버에 메시지 전송
    }
  }
  
  void _showRoomSettings() {
    // TODO: 방 설정 다이얼로그
  }
  
  void _showRoomInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('방 정보'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('방 이름: ${_roomInfo.name}'),
            Text('게임 모드: ${_getModeDisplayName(_roomInfo.mode)}'),
            Text('최대 플레이어: ${_roomInfo.maxPlayers}명'),
            Text('비공개 방: ${_roomInfo.isPrivate ? '예' : '아니요'}'),
            Text('방장: ${_roomInfo.host}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
  
  IconData _getModeIcon(String mode) {
    switch (mode) {
      case 'classic': return Icons.gamepad;
      case 'sprint': return Icons.speed;
      case 'battle': return Icons.swords;
      default: return Icons.gamepad;
    }
  }
  
  String _getModeDisplayName(String mode) {
    switch (mode) {
      case 'classic': return '클래식';
      case 'sprint': return '스프린트';
      case 'battle': return '배틀';
      default: return mode;
    }
  }
}

class RoomInfo {
  final String id;
  final String name;
  final String mode;
  final int maxPlayers;
  final bool isPrivate;
  final String host;
  final String status;
  
  RoomInfo({
    required this.id,
    required this.name,
    required this.mode,
    required this.maxPlayers,
    required this.isPrivate,
    required this.host,
    required this.status,
  });
}

class RoomPlayer {
  final String id;
  final String username;
  final bool isHost;
  final bool isReady;
  final bool isOnline;
  
  RoomPlayer({
    required this.id,
    required this.username,
    required this.isHost,
    required this.isReady,
    required this.isOnline,
  });
}

class ChatMessage {
  final String sender;
  final String message;
  final DateTime timestamp;
  final bool isSystem;
  
  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
    required this.isSystem,
  });
}

class _PlayerTile extends StatelessWidget {
  final RoomPlayer player;
  final String currentUser;
  final VoidCallback? onKick;
  
  const _PlayerTile({
    required this.player,
    required this.currentUser,
    this.onKick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCurrentUser = player.username == currentUser;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          // 아바타
          CircleAvatar(
            radius: 20,
            backgroundColor: isCurrentUser 
                ? theme.colorScheme.primary
                : Colors.grey[600],
            child: Text(
              player.username.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // 플레이어 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      player.username,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isCurrentUser ? theme.colorScheme.primary : null,
                      ),
                    ),
                    if (player.isHost) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber[700],
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: player.isOnline ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      player.isOnline ? '온라인' : '오프라인',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 상태 표시
          if (!player.isHost) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: player.isReady 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                player.isReady ? '준비' : '대기',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: player.isReady ? Colors.green : Colors.orange,
                ),
              ),
            ),
          ],
          
          // 추방 버튼
          if (onKick != null) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.close, size: 16),
              onPressed: onKick,
              color: Colors.red,
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyPlayerSlot extends StatelessWidget {
  final int index;
  
  const _EmptyPlayerSlot({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person_add,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '플레이어 $index',
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessageTile extends StatelessWidget {
  final ChatMessage message;
  
  const _ChatMessageTile({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (message.isSystem) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message.message,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
