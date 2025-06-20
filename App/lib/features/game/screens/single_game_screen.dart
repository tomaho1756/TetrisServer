import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/game_bloc.dart';
import '../widgets/game_board_widget.dart';
import '../widgets/game_info_panel.dart';
import '../widgets/game_controls.dart';
import '../widgets/pause_overlay.dart';
import '../widgets/game_over_dialog.dart';

class SingleGameScreen extends StatefulWidget {
  const SingleGameScreen({super.key});

  @override
  State<SingleGameScreen> createState() => _SingleGameScreenState();
}

class _SingleGameScreenState extends State<SingleGameScreen> {
  Timer? _gameTimer;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 게임 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameBloc>().add(const GameEvent.startSingleGame());
    });
    
    // 키보드 포커스 설정
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _startGameTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      final gameState = context.read<GameBloc>().state;
      if (gameState is _Playing && !gameState.isPaused && !gameState.isGameOver) {
        context.read<GameBloc>().add(const GameEvent.movePiece('down'));
      }
    });
  }

  void _stopGameTimer() {
    _gameTimer?.cancel();
  }

  void _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          context.read<GameBloc>().add(const GameEvent.movePiece('left'));
          break;
        case LogicalKeyboardKey.arrowRight:
          context.read<GameBloc>().add(const GameEvent.movePiece('right'));
          break;
        case LogicalKeyboardKey.arrowDown:
          context.read<GameBloc>().add(const GameEvent.movePiece('down'));
          break;
        case LogicalKeyboardKey.arrowUp:
          context.read<GameBloc>().add(const GameEvent.rotatePiece(true));
          break;
        case LogicalKeyboardKey.space:
          context.read<GameBloc>().add(const GameEvent.dropPiece());
          break;
        case LogicalKeyboardKey.keyC:
          context.read<GameBloc>().add(const GameEvent.holdPiece());
          break;
        case LogicalKeyboardKey.keyP:
        case LogicalKeyboardKey.escape:
          context.read<GameBloc>().add(const GameEvent.pauseGame());
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<GameBloc>().add(const GameEvent.pauseGame());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('싱글플레이'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _showExitDialog();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: () {
                context.read<GameBloc>().add(const GameEvent.pauseGame());
              },
            ),
          ],
        ),
        body: KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: _handleKeyPress,
          child: BlocConsumer<GameBloc, GameState>(
            listener: (context, state) {
              state.when(
                initial: () {},
                loading: () {
                  _stopGameTimer();
                },
                playing: (gameId, board, currentPiece, nextPieces, heldPiece, 
                         score, level, lines, isGameOver, isPaused) {
                  if (isGameOver) {
                    _stopGameTimer();
                    _showGameOverDialog(score, level, lines);
                  } else if (isPaused) {
                    _stopGameTimer();
                  } else {
                    _startGameTimer();
                  }
                },
                gameOver: (finalScore, level, lines) {
                  _stopGameTimer();
                },
                error: (message) {
                  _stopGameTimer();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.when(
                initial: () => const Center(
                  child: Text('게임을 준비하고 있습니다...'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                playing: (gameId, board, currentPiece, nextPieces, heldPiece,
                         score, level, lines, isGameOver, isPaused) {
                  return Stack(
                    children: [
                      // 메인 게임 화면
                      Row(
                        children: [
                          // 왼쪽 정보 패널
                          Expanded(
                            flex: 1,
                            child: GameInfoPanel(
                              heldPiece: heldPiece,
                              score: score,
                              level: level,
                              lines: lines,
                            ),
                          ),
                          
                          // 게임 보드
                          Expanded(
                            flex: 2,
                            child: GameBoardWidget(
                              board: board,
                              currentPiece: currentPiece,
                            ),
                          ),
                          
                          // 오른쪽 정보 패널
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                // 다음 피스들
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'NEXT',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ...nextPieces.take(3).map((piece) => 
                                        Container(
                                          margin: const EdgeInsets.symmetric(vertical: 4),
                                          child: _NextPieceWidget(piece: piece),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const Spacer(),
                                
                                // 게임 컨트롤
                                const GameControls(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      // 일시정지 오버레이
                      if (isPaused)
                        const PauseOverlay(),
                    ],
                  );
                },
                gameOver: (finalScore, level, lines) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'GAME OVER',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Final Score: $finalScore'),
                      Text('Level: $level'),
                      Text('Lines: $lines'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<GameBloc>().add(const GameEvent.restartGame());
                        },
                        child: const Text('다시 시작'),
                      ),
                      TextButton(
                        onPressed: () => context.go('/home'),
                        child: const Text('홈으로'),
                      ),
                    ],
                  ),
                ),
                error: (message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('오류: $message'),
                      ElevatedButton(
                        onPressed: () => context.go('/home'),
                        child: const Text('홈으로'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('게임 종료'),
        content: const Text('정말로 게임을 종료하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/home');
            },
            child: const Text('종료'),
          ),
        ],
      ),
    );
  }

  void _showGameOverDialog(int score, int level, int lines) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GameOverDialog(
        score: score,
        level: level,
        lines: lines,
        onRestart: () {
          Navigator.of(context).pop();
          context.read<GameBloc>().add(const GameEvent.restartGame());
        },
        onHome: () {
          Navigator.of(context).pop();
          context.go('/home');
        },
      ),
    );
  }
}

class _NextPieceWidget extends StatelessWidget {
  final dynamic piece;
  
  const _NextPieceWidget({required this.piece});

  @override
  Widget build(BuildContext context) {
    // TODO: 실제 테트로미노 모양 그리기
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          'T',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
