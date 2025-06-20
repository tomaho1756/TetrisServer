import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '빠른 액션',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                label: '빠른 게임',
                icon: Icons.flash_on,
                color: Colors.red,
                onTap: () => context.go('/game/single'),
              ),
            ),
            
            const SizedBox(width: 12),
            
            Expanded(
              child: _QuickActionButton(
                label: '매치메이킹',
                icon: Icons.search,
                color: Colors.blue,
                onTap: () => context.go('/game/multiplayer'),
              ),
            ),
            
            const SizedBox(width: 12),
            
            Expanded(
              child: _QuickActionButton(
                label: '방 만들기',
                icon: Icons.add_circle,
                color: Colors.green,
                onTap: () => _showCreateRoomDialog(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  void _showCreateRoomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreateRoomDialog(),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  
  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
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
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
  bool _isPrivate = false;
  int _maxPlayers = 4;

  @override
  void dispose() {
    _roomNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
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
            
            Row(
              children: [
                const Text('최대 플레이어: '),
                const Spacer(),
                DropdownButton<int>(
                  value: _maxPlayers,
                  items: [2, 4, 6, 8].map((players) {
                    return DropdownMenuItem<int>(
                      value: players,
                      child: Text('$players명'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _maxPlayers = value ?? 4;
                    });
                  },
                ),
              ],
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
            // TODO: 방 생성 로직 구현
            Navigator.of(context).pop();
            context.go('/rooms');
          },
          child: const Text('만들기'),
        ),
      ],
    );
  }
}
