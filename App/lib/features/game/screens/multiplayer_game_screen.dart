import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/game_bloc.dart';
import '../widgets/game_board_widget.dart';
import '../widgets/game_info_panel.dart';
import '../widgets/game_controls.dart';

class MultiplayerGameScreen extends StatefulWidget {
  final String gameId;
  
  const MultiplayerGameScreen({
    super.key,
    required this.gameId,
  });

  @override
  State<MultiplayerGameScreen> createState() => _MultiplayerGameScreenState();
}

class _MultiplayerGameScreenState extends State<MultiplayerGameScreen> {
  final List<PlayerGameState> _players = [
    PlayerGameState(
      id: '1',
      username: 'Player 1',
      score: 15420,
      level: 3,
      lines: 12,
      isAlive: true,
      rank: 0,
    ),
    PlayerGameState(
      id: '2',
      username: 'Player 2',
      score: 8650,
      level: 2,
      lines: 8,
      isAlive: true,
      rank: 0,
    ),
    PlayerGameState(
      id: '3',
      username: 'Player 3',
      score: 0,
      level: 1,
      lines: 0,
      isAlive: false,
      rank: 3,
    ),
    PlayerGameState(
      id: '4',
      username: 'Player 4',
      score: 12100,
      level: 2,
      lines: 10,
      isAlive: true,
      rank: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('멀티플레이 - ${widget.gameId}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _showExitDialog(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () => _showChatOverlay(),
          ),
        ],
      ),
      body: Column(
        children: [
          // 플레이어 상태 바
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _players.length,
              itemBuilder: (context, index) {
                final player = _players[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: _PlayerStatusCard(player: player),
                );
              },
            ),
          ),
          
          // 메인 게임 영역
          Expanded(
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return state.maybeWhen(
                  playing: (gameId, board, currentPiece, nextPieces, heldPiece,
                           score, level, lines, isGameOver, isPaused) {
                    return Row(
                      children: [
                        // 왼쪽 정보 패널
                        Expanded(
                          flex: 1,
                          child: GameInfoPanel(
                            heldPiece: heldPiece,
                            score: score,
                            level: level,
                            lines: lines,
                          ),
                        ),
                        
                        // 메인 게임 보드
                        Expanded(
                          flex: 2,
                          child: GameBoardWidget(
                            board: board,
                            currentPiece: currentPiece,
                          ),
                        ),
                        
                        // 오른쪽 패널 (다음 피스 + 컨트롤)
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              // 다음 피스들
                              Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'NEXT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ...nextPieces.take(3).map((piece) => 
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 4),
                                        child: _NextPieceWidget(piece: piece),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const Spacer(),
                              
                              // 공격 대상 선택
                              Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'TARGET',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    DropdownButton<String>(
                                      value: 'Player 2',
                                      dropdownColor: Colors.red[800],
                                      style: const TextStyle(color: Colors.white),
                                      items: _players
                                          .where((p) => p.isAlive && p.id != '1')
                                          .map((player) => DropdownMenuItem(
                                                value: player.username,
                                                child: Text(player.username),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        // TODO: 공격 대상 변경 로직
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // 게임 컨트롤
                              const GameControls(),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('게임 나가기'),
        content: const Text('정말로 게임을 나가시겠습니까?\n게임에서 패배 처리됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/home');
            },
            child: const Text('나가기'),
          ),
        ],
      ),
    );
  }
  
  void _showChatOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _ChatOverlay(),
    );
  }
}

class PlayerGameState {
  final String id;
  final String username;
  final int score;
  final int level;
  final int lines;
  final bool isAlive;
  final int rank; // 0 = 진행중, 1 = 1등, 2 = 2등, etc.
  
  PlayerGameState({
    required this.id,
    required this.username,
    required this.score,
    required this.level,
    required this.lines,
    required this.isAlive,
    required this.rank,
  });
}

class _PlayerStatusCard extends StatelessWidget {
  final PlayerGameState player;
  
  const _PlayerStatusCard({required this.player});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      color: player.isAlive 
          ? theme.colorScheme.surface
          : Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: player.isAlive ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    player.username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: player.isAlive ? null : Colors.grey[400],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (player.rank > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getRankColor(player.rank),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '#${player.rank}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${_formatScore(player.score)}',
              style: TextStyle(
                fontSize: 11,
                color: player.isAlive ? theme.colorScheme.primary : Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Lv.${player.level} • ${player.lines}L',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getRankColor(int rank) {
    switch (rank) {
      case 1: return Colors.amber;
      case 2: return Colors.grey[400]!;
      case 3: return Colors.brown;
      default: return Colors.grey;
    }
  }
  
  String _formatScore(int score) {
    if (score >= 1000000) {
      return '${(score / 1000000).toStringAsFixed(1)}M';
    } else if (score >= 1000) {
      return '${(score / 1000).toStringAsFixed(1)}K';
    }
    return score.toString();
  }
}

class _NextPieceWidget extends StatelessWidget {
  final dynamic piece;
  
  const _NextPieceWidget({required this.piece});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          'T',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ChatOverlay extends StatefulWidget {
  const _ChatOverlay();

  @override
  State<_ChatOverlay> createState() => _ChatOverlayState();
}

class _ChatOverlayState extends State<_ChatOverlay> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      sender: 'Player 2',
      message: '안녕하세요!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    ChatMessage(
      sender: 'Player 4',
      message: '화이팅!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  '채팅',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          
          // 메시지 목록
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _ChatBubble(message: message);
              },
            ),
          ),
          
          // 입력 필드
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: '메시지 입력...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
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
    );
  }
  
  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          sender: 'You',
          message: _messageController.text.trim(),
          timestamp: DateTime.now(),
        ));
      });
      _messageController.clear();
    }
  }
}

class ChatMessage {
  final String sender;
  final String message;
  final DateTime timestamp;
  
  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
  });
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.sender == 'You';
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              child: Text(
                message.sender.substring(0, 1),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  Text(
                    message.sender,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Text(
                  message.message,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              child: Text(
                message.sender.substring(0, 1),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
