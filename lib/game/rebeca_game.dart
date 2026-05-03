import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/input/input_controller.dart';

class RebecaGame extends FlameGame with PanZoomListener {
  late InputController _inputController;

  @override
  Future<void> onLoad() async {
    _inputController = InputController();
    super.onLoad();
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    _inputController.updateInput(details.delta.dx, details.delta.dy);
    super.onPanUpdate(details);
  }

  @override
  void render(Canvas canvas) {
    // Use _inputController.normalizedX and _inputController.normalizedY for rendering
    super.render(canvas);
  }

  @override
  void update(double dt) {
    // Use _inputController.normalizedX and _inputController.normalizedY for updating game state
    super.update(dt);
  }
}
