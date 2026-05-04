import 'package:flutter/material.dart';

class PlayerController with ChangeNotifier {
  bool _isWalking = false;

  bool get isWalking => _isWalking;

  void handleKeyPress(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.keyW) ||
        event.isKeyPressed(LogicalKeyboardKey.keyA) ||
        event.isKeyPressed(LogicalKeyboardKey.keyS) ||
        event.isKeyPressed(LogicalKeyboardKey.keyD)) {
      _isWalking = true;
      notifyListeners();
    } else if (event is RawKeyUpEvent) {
      _isWalking = false;
      notifyListeners();
    }
  }

  void reset() {
    _isWalking = false;
    notifyListeners();
  }
}
