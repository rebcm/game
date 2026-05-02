import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OptimizedAnimation extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
      initialValue: 0.0,
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          // Assuming the animation is driven by a sprite sheet or similar
          return Transform.translate(
            offset: Offset(animationController.value * 100, 0),
            child: Image.asset('assets/animations/optimized_animation.png'),
          );
        },
      ),
    );
  }
}
