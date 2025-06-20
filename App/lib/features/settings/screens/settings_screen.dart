import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/settings_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (settings) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 디스플레이 설정
                _SettingsSection(
                  title: '디스플레이',
                  children: [
                    _ThemeSelector(currentTheme: settings.themeMode),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // 오디오 설정
                _SettingsSection(
                  title: '오디오',
                  children: [
                    _SettingsSwitch(
                      title: '효과음',
                      subtitle: '게임 효과음 재생',
                      value: settings.soundEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateSoundEnabled(value),
                        );
                      },
                    ),
                    _SettingsSwitch(
                      title: '배경음악',
                      subtitle: '게임 배경음악 재생',
                      value: settings.musicEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateMusicEnabled(value),
                        );
                      },
                    ),
                    _SettingsSwitch(
                      title: '진동',
                      subtitle: '게임 이벤트 시 진동',
                      value: settings.vibrationEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateVibrationEnabled(value),
                        );
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // 게임플레이 설정
                _SettingsSection(
                  title: '게임플레이',
                  children: [
                    _SettingsSwitch(
                      title: '고스트 피스',
                      subtitle: '떨어질 위치 미리보기',
                      value: settings.showGhost,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateShowGhost(value),
                        );
                      },
                    ),
                    _SettingsSwitch(
                      title: '자동 회전',
                      subtitle: '벽킥 시 자동 회전',
                      value: settings.autoRotate,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateAutoRotate(value),
                        );
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // 컨트롤 설정
                _SettingsSection(
                  title: '컨트롤',
                  children: [
                    _SettingsSlider(
                      title: 'DAS (Delayed Auto Shift)',
                      subtitle: '키 반복 시작 지연 시간',
                      value: settings.das.toDouble(),
                      min: 50,
                      max: 300,
                      divisions: 25,
                      label: '${settings.das}ms',
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateDAS(value.round()),
                        );
                      },
                    ),
                    _SettingsSlider(
                      title: 'ARR (Auto Repeat Rate)',
                      subtitle: '키 반복 간격',
                      value: settings.arr.toDouble(),
                      min: 16,
                      max: 100,
                      divisions: 21,
                      label: '${settings.arr}ms',
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateARR(value.round()),
                        );
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // 계정 설정
                _SettingsSection(
                  title: '계정',
                  children: [
                    _SettingsTile(
                      title: '프로필',
                      subtitle: '프로필 정보 보기',
                      icon: Icons.person,
                      onTap: () => context.go('/profile'),
                    ),
                    _SettingsTile(
                      title: '로그아웃',
                      subtitle: '계정에서 로그아웃',
                      icon: Icons.logout,
                      isDestructive: true,
                      onTap: () => _showLogoutDialog(context),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // 기타
                _SettingsSection(
                  title: '기타',
                  children: [
                    _SettingsTile(
                      title: '앱 정보',
                      subtitle: '버전 및 라이선스 정보',
                      icon: Icons.info,
                      onTap: () => _showAboutDialog(context),
                    ),
                    _SettingsTile(
                      title: '설정 초기화',
                      subtitle: '모든 설정을 기본값으로 되돌리기',
                      icon: Icons.restore,
                      isDestructive: true,
                      onTap: () => _showResetDialog(context),
                    ),
                  ],
                ),
                
                const SizedBox(height: 100),
              ],
            ),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '설정을 불러올 수 없습니다',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SettingsBloc>().add(
                        const SettingsEvent.loadSettings(),
                      );
                    },
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말로 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthBloc>().add(const AuthEvent.logout());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );
  }
  
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('설정 초기화'),
        content: const Text('모든 설정이 기본값으로 되돌아갑니다.\n이 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<SettingsBloc>().add(
                const SettingsEvent.resetSettings(),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('설정이 초기화되었습니다'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('초기화'),
          ),
        ],
      ),
    );
  }
  
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Tetris Multiplayer',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Tetris Multiplayer Team',
      children: [
        const SizedBox(height: 16),
        const Text(
          '온라인 멀티플레이어 테트리스 게임입니다.\n'
          '친구들과 함께 즐거운 테트리스 배틀을 경험해보세요!',
        ),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  
  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isDestructive;
  
  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  
  const _SettingsSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class _SettingsSlider extends StatelessWidget {
  final String title;
  final String subtitle;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String label;
  final ValueChanged<double> onChanged;
  
  const _SettingsSlider({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          const SizedBox(height: 8),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: label,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  final ThemeMode currentTheme;
  
  const _ThemeSelector({required this.currentTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('테마'),
          subtitle: const Text('앱 테마 선택'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('라이트'),
                value: ThemeMode.light,
                groupValue: currentTheme,
                onChanged: (value) {
                  if (value != null) {
                    context.read<SettingsBloc>().add(
                      SettingsEvent.updateThemeMode(value),
                    );
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('다크'),
                value: ThemeMode.dark,
                groupValue: currentTheme,
                onChanged: (value) {
                  if (value != null) {
                    context.read<SettingsBloc>().add(
                      SettingsEvent.updateThemeMode(value),
                    );
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('시스템 설정'),
                value: ThemeMode.system,
                groupValue: currentTheme,
                onChanged: (value) {
                  if (value != null) {
                    context.read<SettingsBloc>().add(
                      SettingsEvent.updateThemeMode(value),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
