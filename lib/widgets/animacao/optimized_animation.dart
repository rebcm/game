import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'repainter.dart';

class OptimizedAnimation extends HookWidget {
  final AnimationController controller;

  const OptimizedAnimation({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Repainter(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(controller.value * 100, 0),
            child: child,
          );
        },
        child: // seu widget de animação aqui,
      ),
    );
  }
}
