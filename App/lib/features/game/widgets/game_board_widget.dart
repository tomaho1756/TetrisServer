import 'package:flutter/material.dart';
import '../../../core/models/game_board.dart';
import '../../../core/models/tetromino.dart';

class GameBoardWidget extends StatelessWidget {
  final GameBoard board;
  final Tetromino? currentPiece;
  
  const GameBoardWidget({
    super.key,
    required this.board,
    this.currentPiece,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AspectRatio(
        aspectRatio: 10 / 20, // 테트리스 보드 비율
        child: CustomPaint(
          painter: GameBoardPainter(
            board: board,
            currentPiece: currentPiece,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class GameBoardPainter extends CustomPainter {
  final GameBoard board;
  final Tetromino? currentPiece;
  
  GameBoardPainter({
    required this.board,
    this.currentPiece,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / 10;
    final cellHeight = size.height / 20;
    
    // 보드 그리드 그리기
    _drawGrid(canvas, size, cellWidth, cellHeight);
    
    // 고정된 블록들 그리기
    _drawFixedBlocks(canvas, cellWidth, cellHeight);
    
    // 현재 피스 그리기
    if (currentPiece != null) {
      _drawCurrentPiece(canvas, cellWidth, cellHeight);
    }
    
    // 고스트 피스 그리기 (미리보기)
    if (currentPiece != null) {
      _drawGhostPiece(canvas, cellWidth, cellHeight);
    }
  }
  
  void _drawGrid(Canvas canvas, Size size, double cellWidth, double cellHeight) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;
    
    // 수직선
    for (int i = 0; i <= 10; i++) {
      final x = i * cellWidth;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // 수평선
    for (int i = 0; i <= 20; i++) {
      final y = i * cellHeight;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }
  
  void _drawFixedBlocks(Canvas canvas, double cellWidth, double cellHeight) {
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
        final cellValue = board.getCell(x, y);
        if (cellValue != 0) {
          _drawBlock(
            canvas,
            x * cellWidth,
            y * cellHeight,
            cellWidth,
            cellHeight,
            _getColorFromValue(cellValue),
          );
        }
      }
    }
  }
  
  void _drawCurrentPiece(Canvas canvas, double cellWidth, double cellHeight) {
    if (currentPiece == null) return;
    
    final color = _getTetrominoColor(currentPiece!.type);
    final shape = currentPiece!.getShape();
    
    for (int y = 0; y < shape.length; y++) {
      for (int x = 0; x < shape[y].length; x++) {
        if (shape[y][x] == 1) {
          final blockX = (currentPiece!.x + x) * cellWidth;
          final blockY = (currentPiece!.y + y) * cellHeight;
          
          _drawBlock(
            canvas,
            blockX,
            blockY,
            cellWidth,
            cellHeight,
            color,
          );
        }
      }
    }
  }
  
  void _drawGhostPiece(Canvas canvas, double cellWidth, double cellHeight) {
    if (currentPiece == null) return;
    
    // 고스트 피스 위치 계산 (바닥까지 떨어뜨린 위치)
    final ghostPiece = currentPiece!.copyWith();
    while (board.canPlacePiece(ghostPiece)) {
      ghostPiece.y++;
    }
    ghostPiece.y--; // 한 칸 위로
    
    if (ghostPiece.y == currentPiece!.y) return; // 같은 위치면 그리지 않음
    
    final color = _getTetrominoColor(currentPiece!.type).withOpacity(0.3);
    final shape = ghostPiece.getShape();
    
    for (int y = 0; y < shape.length; y++) {
      for (int x = 0; x < shape[y].length; x++) {
        if (shape[y][x] == 1) {
          final blockX = (ghostPiece.x + x) * cellWidth;
          final blockY = (ghostPiece.y + y) * cellHeight;
          
          _drawBlock(
            canvas,
            blockX,
            blockY,
            cellWidth,
            cellHeight,
            color,
            isGhost: true,
          );
        }
      }
    }
  }
  
  void _drawBlock(
    Canvas canvas,
    double x,
    double y,
    double width,
    double height,
    Color color, {
    bool isGhost = false,
  }) {
    final rect = Rect.fromLTWH(x, y, width, height);
    
    if (isGhost) {
      // 고스트 피스는 테두리만
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRect(rect.deflate(1), paint);
    } else {
      // 일반 블록
      final paint = Paint()..color = color;
      canvas.drawRect(rect.deflate(1), paint);
      
      // 블록 하이라이트 효과
      final highlightPaint = Paint()
        ..color = Colors.white.withOpacity(0.3);
      canvas.drawRect(
        Rect.fromLTWH(x + 1, y + 1, width - 4, 3),
        highlightPaint,
      );
      canvas.drawRect(
        Rect.fromLTWH(x + 1, y + 1, 3, height - 4),
        highlightPaint,
      );
      
      // 블록 그림자 효과
      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.3);
      canvas.drawRect(
        Rect.fromLTWH(x + width - 4, y + 4, 3, height - 5),
        shadowPaint,
      );
      canvas.drawRect(
        Rect.fromLTWH(x + 4, y + height - 4, width - 5, 3),
        shadowPaint,
      );
    }
  }
  
  Color _getColorFromValue(int value) {
    switch (value) {
      case 1: return Colors.cyan;     // I
      case 2: return Colors.blue;     // J
      case 3: return Colors.orange;   // L
      case 4: return Colors.yellow;   // O
      case 5: return Colors.green;    // S
      case 6: return Colors.purple;   // T
      case 7: return Colors.red;      // Z
      default: return Colors.grey;
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
  bool shouldRepaint(GameBoardPainter oldDelegate) {
    return board != oldDelegate.board || 
           currentPiece != oldDelegate.currentPiece;
  }
}
