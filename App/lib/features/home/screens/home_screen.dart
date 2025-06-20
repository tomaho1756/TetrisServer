import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../widgets/game_mode_card.dart';
import '../widgets/user_stats_card.dart';
import '../widgets/quick_actions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/game/single'),
        child: const Icon(Icons.play_arrow),
        tooltip: '빠른 게임',
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return authState.maybeWhen(
          authenticated: (user) => CustomScrollView(
            slivers: [
              // 앱바
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    '안녕하세요, ${user.username}님!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // 배경 패턴
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.1,
                            child: CustomPaint(
                              painter: TetrisPatternPainter(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () => context.go('/profile'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => context.go('/settings'),
                  ),
                ],
              ),
              
              // 컨텐츠
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // 사용자 통계
                    UserStatsCard(user: user),
                    
                    const SizedBox(height: 24),
                    
                    // 게임 모드 섹션
                    Text(
                      '게임 모드',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 게임 모드 그리드
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        GameModeCard(
                          title: '싱글플레이',
                          subtitle: '혼자서 즐기기',
                          icon: Icons.person,
                          color: Colors.blue,
                          onTap: () => context.go('/game/single'),
                        ),
                        GameModeCard(
                          title: '멀티플레이',
                          subtitle: '다른 플레이어와 대전',
                          icon: Icons.people,
                          color: Colors.green,
                          onTap: () => context.go('/game/multiplayer'),
                        ),
                        GameModeCard(
                          title: '방 목록',
                          subtitle: '게임 방 둘러보기',
                          icon: Icons.meeting_room,
                          color: Colors.orange,
                          onTap: () => context.go('/rooms'),
                        ),
                        GameModeCard(
                          title: '리더보드',
                          subtitle: '순위 확인하기',
                          icon: Icons.leaderboard,
                          color: Colors.purple,
                          onTap: () => context.go('/leaderboard'),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 빠른 액션
                    const QuickActions(),
                    
                    const SizedBox(height: 100), // FAB 공간
                  ]),
                ),
              ),
            ],
          ),
          orElse: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class TetrisPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const blockSize = 30.0;
    
    for (double x = 0; x < size.width; x += blockSize) {
      for (double y = 0; y < size.height; y += blockSize) {
        if ((x / blockSize + y / blockSize) % 3 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(x, y, blockSize - 2, blockSize - 2),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
