import 'package:flutter/material.dart';
import 'package:game/utils/focus_detector.dart';

class InputService with ChangeNotifier {
  final FocusDetector _focusDetector;

  InputService(this._focusDetector);

  bool get shouldPreventDefault => !_focusDetector.hasFocus;

  void onKeyEvent(RawKeyEvent event) {
    if (shouldPreventDefault) {
      // Prevent default browser behavior
    }
  }
}
