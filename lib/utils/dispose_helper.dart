import 'package:flutter/material.dart';

class DisposeHelper {
  static void disposeControllers(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  static void disposeAnimationControllers(List<AnimationController> controllers) {
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
