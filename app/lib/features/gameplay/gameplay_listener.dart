import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'input_manager.dart';

class GameplayListener with ChangeNotifier {
  final InputManager _inputManager;

  GameplayListener(this._inputManager) {
    _inputManager.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    if (_inputManager.isBreakingBlock) {
      // Break block logic here
    }
    if (_inputManager.isPlacingBlock) {
      // Place block logic here
    }
    if (_inputManager.isJumping) {
      // Jump logic here
    }
    if (_inputManager.isMovingForward || _inputManager.isMovingBackward || _inputManager.isMovingLeft || _inputManager.isMovingRight) {
      // Move player logic here
    }
    notifyListeners();
  }
}
