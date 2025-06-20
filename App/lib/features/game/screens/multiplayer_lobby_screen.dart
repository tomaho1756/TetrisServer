import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/bloc/auth_bloc.dart';

class MultiplayerLobbyScreen extends StatefulWidget {
  const MultiplayerLobbyScreen({super.key});

  @override
  State<MultiplayerLobbyScreen> createState() => _MultiplayerLobbyScreenState();
}

class _MultiplayerLobbyScreenState extends State<MultiplayerLobbyScreen> {
  bool _isSearching = false;
  String _selectedMode = 'classic';
  int _selectedPlayerCount = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('멀티플레이'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return authState.maybeWhen(
            authenticated: (user) => SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 사용자 정보 카드
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: theme.colorScheme.primary,
                            child: Text(
                              user.username.substring(0, 1).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.username,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Level ${_calculateLevel(user.totalGames)} • ${user.wins}승',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '온라인',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 게임 모드 선택
                  Text(
                    '게임 모드',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _GameModeSelector(
                    selectedMode: _selectedMode,
                    onModeChanged: (mode) {
                      setState(() {
                        _selectedMode = mode;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 플레이어 수 선택
                  Text(
                    '플레이어 수',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _PlayerCountSelector(
                    selectedCount: _selectedPlayerCount,
                    onCountChanged: (count) {
                      setState(() {
                        _selectedPlayerCount = count;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 매치메이킹 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: _isSearching ? null : _startMatchmaking,
                      icon: _isSearching 
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.search),
                      label: Text(
                        _isSearching ? '매칭 중...' : '매치 찾기',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 방 만들기/참가 버튼
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.go('/rooms'),
                          icon: const Icon(Icons.meeting_room),
                          label: const Text('방 둘러보기'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _showCreateRoomDialog,
                          icon: const Icon(Icons.add),
                          label: const Text('방 만들기'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  if (_isSearching) ...[
                    const SizedBox(height: 32),
                    
                    // 매칭 진행 상황
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              '매칭을 찾고 있습니다...',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '모드: $_selectedMode • ${_selectedPlayerCount}명',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 16),
                            LinearProgressIndicator(
                              backgroundColor: theme.colorScheme.primary.withOpacity(0.3),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: _cancelMatchmaking,
                              child: const Text('매칭 취소'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
  
  int _calculateLevel(int totalGames) {
    return (totalGames / 10).floor() + 1;
  }
  
  void _startMatchmaking() {
    setState(() {
      _isSearching = true;
    });
    
    // TODO: 실제 매치메이킹 로직 구현
    // 임시로 3초 후 가짜 매치 생성
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isSearching) {
        setState(() {
          _isSearching = false;
        });
        context.go('/game/multiplayer/test-game-id');
      }
    });
  }
  
  void _cancelMatchmaking() {
    setState(() {
      _isSearching = false;
    });
  }
  
  void _showCreateRoomDialog() {
    // TODO: 방 생성 다이얼로그 표시
    context.go('/rooms');
  }
}

class _GameModeSelector extends StatelessWidget {
  final String selectedMode;
  final ValueChanged<String> onModeChanged;
  
  const _GameModeSelector({
    required this.selectedMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final modes = [
      {'id': 'classic', 'name': '클래식', 'description': '기본 테트리스 모드'},
      {'id': 'sprint', 'name': '스프린트', 'description': '40라인 빠르게 지우기'},
      {'id': 'battle', 'name': '배틀', 'description': '공격과 방어'},
    ];
    
    return Column(
      children: modes.map((mode) {
        final isSelected = selectedMode == mode['id'];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Card(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : null,
            child: InkWell(
              onTap: () => onModeChanged(mode['id']!),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Radio<String>(
                      value: mode['id']!,
                      groupValue: selectedMode,
                      onChanged: (value) => onModeChanged(value!),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mode['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            mode['description']!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PlayerCountSelector extends StatelessWidget {
  final int selectedCount;
  final ValueChanged<int> onCountChanged;
  
  const _PlayerCountSelector({
    required this.selectedCount,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    final counts = [2, 4, 6, 8];
    
    return Row(
      children: counts.map((count) {
        final isSelected = selectedCount == count;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text('${count}명'),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onCountChanged(count);
                }
              },
              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              labelStyle: TextStyle(
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary
                    : null,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
