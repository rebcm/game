import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OptimizedAnimation extends HookWidget {
  const OptimizedAnimation({Key? key}) : super(key: key);

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
          // Implement the animation logic here
          return Transform.scale(
            scale: animationController.value,
            child: child,
          );
        },
        child: // Your animated child widget here,
      ),
    );
  }
}
