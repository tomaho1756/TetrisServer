import 'package:flutter/material.dart';
import '../../../core/models/tetromino.dart';

class GameInfoPanel extends StatelessWidget {
  final Tetromino? heldPiece;
  final int score;
  final int level;
  final int lines;
  
  const GameInfoPanel({
    super.key,
    this.heldPiece,
    required this.score,
    required this.level,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          // HOLD 섹션
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Column(
              children: [
                Text(
                  'HOLD',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: heldPiece != null
                      ? TetrominoPreview(piece: heldPiece!)
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 스코어 정보
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Column(
              children: [
                _InfoRow(
                  label: 'SCORE',
                  value: _formatNumber(score),
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  label: 'LEVEL',
                  value: level.toString(),
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  label: 'LINES',
                  value: lines.toString(),
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  label: 'GOAL',
                  value: _calculateGoal(level).toString(),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // 컨트롤 가이드
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONTROLS',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _ControlRow('←→', '이동'),
                _ControlRow('↓', '소프트 드롭'),
                _ControlRow('↑', '회전'),
                _ControlRow('SPACE', '하드 드롭'),
                _ControlRow('C', '홀드'),
                _ControlRow('P', '일시정지'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
  
  int _calculateGoal(int level) {
    return (level + 1) * 10;
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  
  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ControlRow extends StatelessWidget {
  final String key;
  final String action;
  
  const _ControlRow(this.key, this.action);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              key,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              action,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[400],
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TetrominoPreview extends StatelessWidget {
  final Tetromino piece;
  
  const TetrominoPreview({
    super.key,
    required this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TetrominoPainter(piece: piece),
      size: const Size(60, 60),
    );
  }
}

class TetrominoPainter extends CustomPainter {
  final Tetromino piece;
  
  TetrominoPainter({required this.piece});

  @override
  void paint(Canvas canvas, Size size) {
    final shape = piece.getShape();
    final cellSize = size.width / 4; // 4x4 그리드 기준
    final color = _getTetrominoColor(piece.type);
    
    for (int y = 0; y < shape.length; y++) {
      for (int x = 0; x < shape[y].length; x++) {
        if (shape[y][x] == 1) {
          final rect = Rect.fromLTWH(
            x * cellSize + 2,
            y * cellSize + 2,
            cellSize - 4,
            cellSize - 4,
          );
          
          final paint = Paint()..color = color;
          canvas.drawRect(rect, paint);
          
          // 하이라이트 효과
          final highlightPaint = Paint()
            ..color = Colors.white.withOpacity(0.3);
          canvas.drawRect(
            Rect.fromLTWH(rect.left, rect.top, rect.width, 2),
            highlightPaint,
          );
          canvas.drawRect(
            Rect.fromLTWH(rect.left, rect.top, 2, rect.height),
            highlightPaint,
          );
        }
      }
    }
  }
  
  Color _getTetrominoColor(String type) {
    switch (type) {
      case 'I': return Colors.cyan;
      case 'J': return Colors.blue;
      case 'L': return Colors.orange;
      case 'O': return Colors.yellow;
      case 'S': return Colors.green;
      case 'T': return Colors.purple;
      case 'Z': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  bool shouldRepaint(TetrominoPainter oldDelegate) {
    return piece != oldDelegate.piece;
  }
}
