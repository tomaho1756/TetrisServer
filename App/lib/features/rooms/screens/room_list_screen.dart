import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  bool _showFullRooms = true;
  
  final List<GameRoom> _rooms = [
    GameRoom(
      id: 'room1',
      name: '빠른 대전방',
      mode: 'classic',
      currentPlayers: 2,
      maxPlayers: 4,
      isPrivate: false,
      host: 'SpeedMaster',
      status: 'waiting',
    ),
    GameRoom(
      id: 'room2',
      name: '초보자 환영',
      mode: 'classic',
      currentPlayers: 1,
      maxPlayers: 2,
      isPrivate: false,
      host: 'NewbieFriend',
      status: 'waiting',
    ),
    GameRoom(
      id: 'room3',
      name: '고수만',
      mode: 'battle',
      currentPlayers: 3,
      maxPlayers: 4,
      isPrivate: true,
      host: 'ProGamer',
      status: 'waiting',
    ),
    GameRoom(
      id: 'room4',
      name: '스프린트 경주',
      mode: 'sprint',
      currentPlayers: 4,
      maxPlayers: 4,
      isPrivate: false,
      host: 'FastRunner',
      status: 'playing',
    ),
    GameRoom(
      id: 'room5',
      name: '친목방',
      mode: 'classic',
      currentPlayers: 2,
      maxPlayers: 6,
      isPrivate: false,
      host: 'FriendlyUser',
      status: 'waiting',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredRooms = _getFilteredRooms();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('방 목록'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshRooms,
          ),
        ],
      ),
      body: Column(
        children: [
          // 검색 및 필터
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.surface,
            child: Column(
              children: [
                // 검색 바
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: '방 이름 검색...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                
                const SizedBox(height: 16),
                
                // 필터 옵션
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedFilter,
                        decoration: InputDecoration(
                          labelText: '게임 모드',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'all', child: Text('전체')),
                          DropdownMenuItem(value: 'classic', child: Text('클래식')),
                          DropdownMenuItem(value: 'sprint', child: Text('스프린트')),
                          DropdownMenuItem(value: 'battle', child: Text('배틀')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value ?? 'all';
                          });
                        },
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // 꽉찬 방 표시 토글
                    Row(
                      children: [
                        Checkbox(
                          value: _showFullRooms,
                          onChanged: (value) {
                            setState(() {
                              _showFullRooms = value ?? true;
                            });
                          },
                        ),
                        const Text('꽉찬 방'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 방 목록
          Expanded(
            child: filteredRooms.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.meeting_room_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '조건에 맞는 방이 없습니다',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '새로운 방을 만들어보세요!',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      final room = filteredRooms[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: RoomCard(
                          room: room,
                          onJoin: () => _joinRoom(room),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateRoomDialog,
        icon: const Icon(Icons.add),
        label: const Text('방 만들기'),
      ),
    );
  }
  
  List<GameRoom> _getFilteredRooms() {
    return _rooms.where((room) {
      // 검색어 필터
      if (_searchController.text.isNotEmpty) {
        if (!room.name.toLowerCase().contains(
            _searchController.text.toLowerCase())) {
          return false;
        }
      }
      
      // 게임 모드 필터
      if (_selectedFilter != 'all' && room.mode != _selectedFilter) {
        return false;
      }
      
      // 꽉찬 방 필터
      if (!_showFullRooms && room.isFull) {
        return false;
      }
      
      return true;
    }).toList();
  }
  
  void _refreshRooms() {
    // TODO: 서버에서 방 목록 새로고침
    setState(() {});
  }
  
  void _joinRoom(GameRoom room) {
    if (room.isPrivate) {
      _showPasswordDialog(room);
    } else if (room.isFull) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('방이 가득 찼습니다'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      context.go('/rooms/${room.id}');
    }
  }
  
  void _showPasswordDialog(GameRoom room) {
    final passwordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('비밀번호 입력'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: '비밀번호',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: 비밀번호 확인 로직
              Navigator.of(context).pop();
              context.go('/rooms/${room.id}');
            },
            child: const Text('입장'),
          ),
        ],
      ),
    );
  }
  
  void _showCreateRoomDialog() {
    showDialog(
      context: context,
      builder: (context) => const CreateRoomDialog(),
    );
  }
}

class GameRoom {
  final String id;
  final String name;
  final String mode;
  final int currentPlayers;
  final int maxPlayers;
  final bool isPrivate;
  final String host;
  final String status; // waiting, playing, finished
  
  GameRoom({
    required this.id,
    required this.name,
    required this.mode,
    required this.currentPlayers,
    required this.maxPlayers,
    required this.isPrivate,
    required this.host,
    required this.status,
  });
  
  bool get isFull => currentPlayers >= maxPlayers;
  bool get isWaiting => status == 'waiting';
  bool get isPlaying => status == 'playing';
}

class RoomCard extends StatelessWidget {
  final GameRoom room;
  final VoidCallback onJoin;
  
  const RoomCard({
    super.key,
    required this.room,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: room.isWaiting ? onJoin : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 첫 번째 줄: 방 이름과 상태
              Row(
                children: [
                  Expanded(
                    child: Text(
                      room.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _StatusChip(status: room.status),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // 두 번째 줄: 호스트와 게임 모드
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    room.host,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    _getModeIcon(room.mode),
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getModeDisplayName(room.mode),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // 세 번째 줄: 플레이어 수와 아이콘들
              Row(
                children: [
                  // 플레이어 수
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: room.isFull 
                          ? Colors.red.withOpacity(0.1)
                          : theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${room.currentPlayers}/${room.maxPlayers}',
                      style: TextStyle(
                        color: room.isFull 
                            ? Colors.red
                            : theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // 비공개 방 아이콘
                  if (room.isPrivate) ...[
                    Icon(
                      Icons.lock,
                      size: 16,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(width: 8),
                  ],
                  
                  // 입장 버튼
                  ElevatedButton(
                    onPressed: room.isWaiting ? onJoin : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: room.isWaiting 
                          ? theme.colorScheme.primary
                          : Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      room.isPlaying ? '관전' : '입장',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

class _StatusChip extends StatelessWidget {
  final String status;
  
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;
    
    switch (status) {
      case 'waiting':
        color = Colors.green;
        text = '대기중';
        break;
      case 'playing':
        color = Colors.orange;
        text = '게임중';
        break;
      case 'finished':
        color = Colors.grey;
        text = '종료';
        break;
      default:
        color = Colors.grey;
        text = status;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class CreateRoomDialog extends StatefulWidget {
  const CreateRoomDialog({super.key});

  @override
  State<CreateRoomDialog> createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends State<CreateRoomDialog> {
  final _roomNameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedMode = 'classic';
  int _maxPlayers = 4;
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('방 만들기'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _roomNameController,
              decoration: const InputDecoration(
                labelText: '방 이름',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _selectedMode,
              decoration: const InputDecoration(
                labelText: '게임 모드',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'classic', child: Text('클래식')),
                DropdownMenuItem(value: 'sprint', child: Text('스프린트')),
                DropdownMenuItem(value: 'battle', child: Text('배틀')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedMode = value ?? 'classic';
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            DropdownButtonFormField<int>(
              value: _maxPlayers,
              decoration: const InputDecoration(
                labelText: '최대 플레이어',
                border: OutlineInputBorder(),
              ),
              items: [2, 4, 6, 8].map((count) {
                return DropdownMenuItem<int>(
                  value: count,
                  child: Text('${count}명'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _maxPlayers = value ?? 4;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                const Text('비공개 방'),
                const Spacer(),
                Switch(
                  value: _isPrivate,
                  onChanged: (value) {
                    setState(() {
                      _isPrivate = value;
                    });
                  },
                ),
              ],
            ),
            
            if (_isPrivate) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: 방 생성 로직
            Navigator.of(context).pop();
            context.go('/rooms/new-room-id');
          },
          child: const Text('만들기'),
        ),
      ],
    );
  }
}
