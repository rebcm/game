import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'repainter.dart';

class OptimizedAnimation extends HookWidget {
  final AnimationController controller;_animationController = AnimationController controller;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

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
