import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/animation.dart';

mixin AnimationControllerDisposer on State {_animationController = AnimationControllerDisposer on State {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  final List<AnimationController> _animationControllers = [];_animationController = AnimationController> _animationControllers = [];();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  void addAnimationController(AnimationController controller) {_animationController = AnimationController(AnimationController controller) {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
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
