import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/game_bloc.dart';

class GameControls extends StatelessWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 회전 버튼
          SizedBox(
            width: 60,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                context.read<GameBloc>().add(const GameEvent.rotatePiece(true));
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
              ),
              child: const Icon(Icons.rotate_right, size: 24),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // 이동 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 왼쪽 이동
              _ControlButton(
                icon: Icons.arrow_left,
                onPressed: () {
                  context.read<GameBloc>().add(const GameEvent.movePiece('left'));
                },
              ),
              
              // 아래로 이동
              _ControlButton(
                icon: Icons.arrow_downward,
                onPressed: () {
                  context.read<GameBloc>().add(const GameEvent.movePiece('down'));
                },
              ),
              
              // 오른쪽 이동
              _ControlButton(
                icon: Icons.arrow_right,
                onPressed: () {
                  context.read<GameBloc>().add(const GameEvent.movePiece('right'));
                },
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 액션 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 홀드
              _ActionButton(
                label: 'HOLD',
                icon: Icons.pause_circle,
                onPressed: () {
                  context.read<GameBloc>().add(const GameEvent.holdPiece());
                },
              ),
              
              // 하드 드롭
              _ActionButton(
                label: 'DROP',
                icon: Icons.keyboard_double_arrow_down,
                onPressed: () {
                  context.read<GameBloc>().add(const GameEvent.dropPiece());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  
  const _ControlButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.grey[700],
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.orange[700],
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
              ),
              child: Icon(icon, size: 20),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
