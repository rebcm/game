import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputManager with ChangeNotifier {
  bool _isJumping = false;
  bool _isMovingForward = false;
  bool _isMovingBackward = false;
  bool _isMovingLeft = false;
  bool _isMovingRight = false;
  bool _isBreakingBlock = false;
  bool _isPlacingBlock = false;
  int _selectedBlockIndex = 0;

  bool get isJumping => _isJumping;
  bool get isMovingForward => _isMovingForward;
  bool get isMovingBackward => _isMovingBackward;
  bool get isMovingLeft => _isMovingLeft;
  bool get isMovingRight => _isMovingRight;
  bool get isBreakingBlock => _isBreakingBlock;
  bool get isPlacingBlock => _isPlacingBlock;
  int get selectedBlockIndex => _selectedBlockIndex;

  void handleKeyEvent(RawKeyEvent event) {
    final isKeyDown = event.runtimeType == RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.keyW) {
      _isMovingForward = isKeyDown;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      _isMovingBackward = isKeyDown;
    } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
      _isMovingLeft = isKeyDown;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      _isMovingRight = isKeyDown;
    } else if (event.logicalKey == LogicalKeyboardKey.space) {
      _isJumping = isKeyDown;
    } else if (event.logicalKey == LogicalKeyboardKey.keyE) {
      // Open inventory logic here
    }
    notifyListeners();
  }

  void handleMouseEvent(MouseEvent event) {
    if (event.buttons == kPrimaryButton) {
      _isBreakingBlock = true;
    } else if (event.buttons == kSecondaryButton) {
      _isPlacingBlock = true;
    } else {
      _isBreakingBlock = false;
      _isPlacingBlock = false;
    }
  }

  void handleScrollEvent(double delta) {
    if (delta > 0) {
      _selectedBlockIndex++;
    } else {
      _selectedBlockIndex--;
    }
    notifyListeners();
  }
}
