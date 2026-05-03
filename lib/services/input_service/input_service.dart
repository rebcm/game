import 'package:flutter/services.dart';

class InputService {
  void preventDefaultBrowserBehavior(LogicalKeyboardKey key) {
    if ([
      LogicalKeyboardKey.keyW,
      LogicalKeyboardKey.keyA,
      LogicalKeyboardKey.keyS,
      LogicalKeyboardKey.keyD,
      LogicalKeyboardKey.space,
    ].contains(key)) {
      // Prevent default browser behavior for WASD and Space keys
      // This is typically handled by the RawKeyboardListener or other input handling mechanisms
      // For web, we need to listen to key events and prevent default when necessary
    }
  }
}
