import 'package:flutter/animation.dart';

class CustomAnimationController extends AnimationController {
  CustomAnimationController({required super.vsync}) : super(duration: const Duration(seconds: 1));

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
