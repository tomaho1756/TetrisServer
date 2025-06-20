import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // 임시 리더보드 데이터
  final List<LeaderboardEntry> _highScoreLeaderboard = [
    LeaderboardEntry(rank: 1, username: 'TetrisMaster', score: 2450000, level: 15),
    LeaderboardEntry(rank: 2, username: 'BlockBuster', score: 1980000, level: 13),
    LeaderboardEntry(rank: 3, username: 'LineClearing', score: 1750000, level: 12),
    LeaderboardEntry(rank: 4, username: 'SpeedRunner', score: 1650000, level: 11),
    LeaderboardEntry(rank: 5, username: 'PuzzlePro', score: 1580000, level: 11),
    LeaderboardEntry(rank: 6, username: 'GameMaster', score: 1420000, level: 10),
    LeaderboardEntry(rank: 7, username: 'TetrisKing', score: 1350000, level: 10),
    LeaderboardEntry(rank: 8, username: 'BlockWizard', score: 1280000, level: 9),
    LeaderboardEntry(rank: 9, username: 'LineMaster', score: 1150000, level: 9),
    LeaderboardEntry(rank: 10, username: 'PuzzleKing', score: 1050000, level: 8),
  ];
  
  final List<LeaderboardEntry> _winsLeaderboard = [
    LeaderboardEntry(rank: 1, username: 'VictoryLord', score: 245, level: 0),
    LeaderboardEntry(rank: 2, username: 'WinStreak', score: 198, level: 0),
    LeaderboardEntry(rank: 3, username: 'Champion', score: 175, level: 0),
    LeaderboardEntry(rank: 4, username: 'Winner', score: 165, level: 0),
    LeaderboardEntry(rank: 5, username: 'BattleKing', score: 158, level: 0),
    LeaderboardEntry(rank: 6, username: 'Conqueror', score: 142, level: 0),
    LeaderboardEntry(rank: 7, username: 'Dominator', score: 135, level: 0),
    LeaderboardEntry(rank: 8, username: 'Victorious', score: 128, level: 0),
    LeaderboardEntry(rank: 9, username: 'Triumphant', score: 115, level: 0),
    LeaderboardEntry(rank: 10, username: 'Successful', score: 105, level: 0),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('리더보드'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.star),
              text: '최고 점수',
            ),
            Tab(
              icon: Icon(Icons.emoji_events),
              text: '승수',
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // TODO: 리더보드 새로고침
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('리더보드를 업데이트했습니다'),
                ),
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _LeaderboardTab(
            entries: _highScoreLeaderboard,
            scoreLabel: '점수',
            isScoreType: true,
          ),
          _LeaderboardTab(
            entries: _winsLeaderboard,
            scoreLabel: '승수',
            isScoreType: false,
          ),
        ],
      ),
    );
  }
}

class LeaderboardEntry {
  final int rank;
  final String username;
  final int score;
  final int level;
  
  LeaderboardEntry({
    required this.rank,
    required this.username,
    required this.score,
    required this.level,
  });
}

class _LeaderboardTab extends StatelessWidget {
  final List<LeaderboardEntry> entries;
  final String scoreLabel;
  final bool isScoreType;
  
  const _LeaderboardTab({
    required this.entries,
    required this.scoreLabel,
    required this.isScoreType,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: 리더보드 새로고침 로직
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: entries.length + 1, // +1 for header
        itemBuilder: (context, index) {
          if (index == 0) {
            return _LeaderboardHeader(scoreLabel: scoreLabel);
          }
          
          final entry = entries[index - 1];
          return _LeaderboardTile(
            entry: entry,
            isScoreType: isScoreType,
          );
        },
      ),
    );
  }
}

class _LeaderboardHeader extends StatelessWidget {
  final String scoreLabel;
  
  const _LeaderboardHeader({required this.scoreLabel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.leaderboard,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            '🏆 명예의 전당 🏆',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '최고의 플레이어들과 경쟁해보세요!',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isScoreType;
  
  const _LeaderboardTile({
    required this.entry,
    required this.isScoreType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTopThree = entry.rank <= 3;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: isTopThree ? 8 : 2,
        color: isTopThree 
            ? _getRankColor(entry.rank).withOpacity(0.1)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isTopThree 
              ? BorderSide(
                  color: _getRankColor(entry.rank).withOpacity(0.3),
                  width: 2,
                )
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 순위 아이콘
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isTopThree 
                      ? _getRankColor(entry.rank)
                      : Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isTopThree && entry.rank <= 3
                      ? Icon(
                          _getRankIcon(entry.rank),
                          color: Colors.white,
                          size: 20,
                        )
                      : Text(
                          '${entry.rank}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // 사용자 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.username,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isTopThree 
                            ? _getRankColor(entry.rank)
                            : null,
                      ),
                    ),
                    if (isScoreType && entry.level > 0) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Level ${entry.level}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // 점수/승수
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isScoreType 
                        ? _formatScore(entry.score)
                        : '${entry.score}승',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isTopThree 
                          ? _getRankColor(entry.rank)
                          : theme.colorScheme.primary,
                    ),
                  ),
                  if (isTopThree) ...[
                    const SizedBox(height: 2),
                    Text(
                      _getRankText(entry.rank),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _getRankColor(entry.rank),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.grey;
    }
  }
  
  IconData _getRankIcon(int rank) {
    switch (rank) {
      case 1:
        return Icons.looks_one;
      case 2:
        return Icons.looks_two;
      case 3:
        return Icons.looks_3;
      default:
        return Icons.person;
    }
  }
  
  String _getRankText(int rank) {
    switch (rank) {
      case 1:
        return '👑 1등';
      case 2:
        return '🥈 2등';
      case 3:
        return '🥉 3등';
      default:
        return '';
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
