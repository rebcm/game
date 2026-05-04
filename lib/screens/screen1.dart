import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rebcm/controllers/animation_controller.dart';

class Screen1 extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
      duration: const Duration(seconds: 1),
    )..repeat();

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: animationController.value * 2 * 3.14159,
          child: child,
        );
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}
