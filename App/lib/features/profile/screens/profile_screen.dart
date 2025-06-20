import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../../core/models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditProfileDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            authenticated: (user) => SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 프로필 헤더
                  _ProfileHeader(user: user),
                  
                  const SizedBox(height: 32),
                  
                  // 통계 카드들
                  _StatsGrid(user: user),
                  
                  const SizedBox(height: 24),
                  
                  // 게임 기록
                  _GameHistory(),
                  
                  const SizedBox(height: 24),
                  
                  // 성취
                  _Achievements(user: user),
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
  
  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _EditProfileDialog(),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final User user;
  
  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 아바타
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  user.username.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 사용자명
            Text(
              user.username,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 4),
            
            // 이메일
            Text(
              user.email,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 레벨과 경험치
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Level ${_calculateLevel(user.totalGames)}',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 가입일
            Text(
              '가입일: ${_formatDate(user.createdAt)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  int _calculateLevel(int totalGames) {
    return (totalGames / 10).floor() + 1;
  }
  
  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}

class _StatsGrid extends StatelessWidget {
  final User user;
  
  const _StatsGrid({required this.user});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _StatCard(
          title: '총 게임',
          value: user.totalGames.toString(),
          icon: Icons.games,
          color: Colors.blue,
        ),
        _StatCard(
          title: '승리',
          value: user.wins.toString(),
          icon: Icons.emoji_events,
          color: Colors.amber,
        ),
        _StatCard(
          title: '최고 점수',
          value: _formatScore(user.highScore),
          icon: Icons.star,
          color: Colors.purple,
        ),
        _StatCard(
          title: '승률',
          value: '${_calculateWinRate(user.wins, user.totalGames)}%',
          icon: Icons.trending_up,
          color: Colors.green,
        ),
      ],
    );
  }
  
  String _formatScore(int score) {
    if (score >= 1000000) {
      return '${(score / 1000000).toStringAsFixed(1)}M';
    } else if (score >= 1000) {
      return '${(score / 1000).toStringAsFixed(1)}K';
    }
    return score.toString();
  }
  
  int _calculateWinRate(int wins, int totalGames) {
    if (totalGames == 0) return 0;
    return ((wins / totalGames) * 100).round();
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _GameHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 임시 게임 기록 데이터
    final gameHistory = [
      {'mode': '싱글플레이', 'score': 125000, 'result': 'win', 'date': '2024-01-15'},
      {'mode': '멀티플레이', 'score': 98000, 'result': 'lose', 'date': '2024-01-14'},
      {'mode': '스프린트', 'score': 75000, 'result': 'win', 'date': '2024-01-13'},
      {'mode': '배틀', 'score': 156000, 'result': 'win', 'date': '2024-01-12'},
      {'mode': '멀티플레이', 'score': 87000, 'result': 'lose', 'date': '2024-01-11'},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Text(
            '최근 게임 기록',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        Card(
          child: Column(
            children: gameHistory.map((game) {
              final isWin = game['result'] == 'win';
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isWin 
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isWin ? Icons.emoji_events : Icons.close,
                    color: isWin ? Colors.green : Colors.red,
                    size: 20,
                  ),
                ),
                title: Text(game['mode'] as String),
                subtitle: Text(game['date'] as String),
                trailing: Text(
                  _formatScore(game['score'] as int),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isWin ? Colors.green : Colors.red,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        
        const SizedBox(height: 8),
        
        Center(
          child: TextButton(
            onPressed: () {
              // TODO: 전체 게임 기록 보기
            },
            child: const Text('전체 기록 보기'),
          ),
        ),
      ],
    );
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

class _Achievements extends StatelessWidget {
  final User user;
  
  const _Achievements({required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 임시 성취 데이터
    final achievements = [
      {'title': '첫 승리', 'description': '첫 게임에서 승리하기', 'unlocked': true},
      {'title': '연승왕', 'description': '5연승 달성하기', 'unlocked': user.wins >= 5},
      {'title': '고득점', 'description': '100,000점 달성하기', 'unlocked': user.highScore >= 100000},
      {'title': '베테랑', 'description': '총 50게임 플레이하기', 'unlocked': user.totalGames >= 50},
      {'title': '테트리스 마스터', 'description': '레벨 10 달성하기', 'unlocked': (user.totalGames / 10).floor() + 1 >= 10},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Text(
            '성취',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        Card(
          child: Column(
            children: achievements.map((achievement) {
              final unlocked = achievement['unlocked'] as bool;
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: unlocked 
                        ? Colors.amber.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    unlocked ? Icons.emoji_events : Icons.lock,
                    color: unlocked ? Colors.amber : Colors.grey,
                    size: 20,
                  ),
                ),
                title: Text(
                  achievement['title'] as String,
                  style: TextStyle(
                    color: unlocked ? null : Colors.grey,
                    fontWeight: unlocked ? FontWeight.bold : null,
                  ),
                ),
                subtitle: Text(
                  achievement['description'] as String,
                  style: TextStyle(
                    color: unlocked 
                        ? theme.colorScheme.onSurface.withOpacity(0.7)
                        : Colors.grey,
                  ),
                ),
                trailing: unlocked 
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog();

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('프로필 수정'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: '사용자명',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: '이메일',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: 프로필 업데이트 로직
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('프로필이 업데이트되었습니다'),
              ),
            );
          },
          child: const Text('저장'),
        ),
      ],
    );
  }
}
