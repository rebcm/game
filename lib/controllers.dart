import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';

class GameControllers with ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  final AnimationController animationController;_animationController = AnimationController animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  GameControllers({required TickerProvider vsync})
      : animationController = AnimationController(vsync: vsync);_animationController = AnimationController(vsync: vsync);();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  @override
  void dispose() {
    textController.dispose();
    animationController.dispose();
    super.dispose();
  }
}
