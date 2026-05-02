import 'package:flutter/material.dart';

class GameControllers with ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  final AnimationController animationController;

  GameControllers({required TickerProvider vsync})
      : animationController = AnimationController(vsync: vsync);

  @override
  void dispose() {
    textController.dispose();
    animationController.dispose();
    super.dispose();
  }
}
