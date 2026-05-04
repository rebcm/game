import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';

class DisposeHelper {
  static void disposeControllers(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  static void disposeAnimationControllers(List<AnimationController> controllers) {_animationController = AnimationControllers(List<AnimationController> controllers) {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  static void cancelStreamSubscriptions(List<StreamSubscription> subscriptions) {
    for (var subscription in subscriptions) {
      subscription.cancel();
    }
  }
}
