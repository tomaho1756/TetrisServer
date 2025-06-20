import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  
  const AuthBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(0.1),
            theme.colorScheme.secondary.withOpacity(0.1),
            theme.colorScheme.tertiary.withOpacity(0.1),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // 테트리스 블록 장식
            Positioned(
              top: 50,
              right: 20,
              child: Transform.rotate(
                angle: 0.3,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 30,
              child: Transform.rotate(
                angle: -0.2,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              right: 40,
              child: Transform.rotate(
                angle: 0.5,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 20,
              child: Transform.rotate(
                angle: -0.4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            
            // 메인 컨텐츠
            child,
          ],
        ),
      ),
    );
  }
}
