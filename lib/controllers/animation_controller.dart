import 'package:flutter/animation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomAnimationController extends AnimationController {
  CustomAnimationController({required TickerProvider vsync}) : super(vsync: vsync);

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
