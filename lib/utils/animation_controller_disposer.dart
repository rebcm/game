import 'package:flutter/animation.dart';

mixin AnimationControllerDisposer on State {
  final List<AnimationController> _animationControllers = [];

  void addAnimationController(AnimationController controller) {
    _animationControllers.add(controller);
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
