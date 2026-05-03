import 'package:flutter/animation.dart';

class AnimationSync {
  static double calculatePlaybackRate(double translationSpeed, double animationSpeed) {
    return translationSpeed / animationSpeed;
  }
}
