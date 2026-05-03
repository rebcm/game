import 'package:flutter/material.dart';

class IdleAnimation extends StatefulWidget {
  @override
  _IdleAnimationState createState() => _IdleAnimationState();
}

class _IdleAnimationState extends State<IdleAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationController.value * 0.174533, // 10 graus em radianos
          child: child,
        );
      },
      child: Image.asset('assets/animacoes/rebeca/idle.png'),
    );
  }
}

