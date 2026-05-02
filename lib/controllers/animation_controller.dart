import 'package:flutter/animation.dart';

class CustomAnimationController extends AnimationController {
  CustomAnimationController({required super.vsync, required super.duration});

  @override
  void dispose() {
    super.dispose();
  }
}
