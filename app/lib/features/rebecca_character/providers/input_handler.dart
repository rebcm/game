import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputHandler with ChangeNotifier {
  bool _isWPressed = false;
  bool _isAPressed = false;
  bool _isSPressed = false;
  bool _isDPressed = false;
  bool _isSpacePressed = false;
  bool _isEPressed = false;
  bool _isLeftMousePressed = false;
  bool _isRightMousePressed = false;
  double _mouseScroll = 0.0;

  bool get isWPressed => _isWPressed;
  bool get isAPressed => _isAPressed;
  bool get isSPressed => _isSPressed;
  bool get isDPressed => _isDPressed;
  bool get isSpacePressed => _isSpacePressed;
  bool get isEPressed => _isEPressed;
  bool get isLeftMousePressed => _isLeftMousePressed;
  bool get isRightMousePressed => _isRightMousePressed;
  double get mouseScroll => _mouseScroll;

  void onKeyEvent(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.keyW) {
      _isWPressed = event.runtimeType == RawKeyDownEvent;
    } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
      _isAPressed = event.runtimeType == RawKeyDownEvent;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      _isSPressed = event.runtimeType == RawKeyDownEvent;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      _isDPressed = event.runtimeType == RawKeyDownEvent;
    } else if (event.logicalKey == LogicalKeyboardKey.space) {
      _isSpacePressed = event.runtimeType == RawKeyDownEvent;
    } else if (event.logicalKey == LogicalKeyboardKey.keyE) {
      _isEPressed = event.runtimeType == RawKeyDownEvent;
    }
    notifyListeners();
  }

  void onMouseEvent(MouseEvent event) {
    if (event.buttons == kPrimaryButton) {
      _isLeftMousePressed = event.type == PointerDownEvent;
    } else if (event.buttons == kSecondaryButton) {
      _isRightMousePressed = event.type == PointerDownEvent;
    }
    notifyListeners();
  }

  void onScrollEvent(PointerScrollEvent event) {
    _mouseScroll = event.scrollDelta.dy;
    notifyListeners();
  }

  void resetMouseScroll() {
    _mouseScroll = 0.0;
    notifyListeners();
  }
}
