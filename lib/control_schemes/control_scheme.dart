import 'package:flutter/services.dart';

abstract class ControlScheme {
  void handleKeyEvent(RawKeyEvent event);
}

class DefaultControlScheme implements ControlScheme {
  @override
  void handleKeyEvent(RawKeyEvent event) {
    // Implement default key event handling
  }
}

class AlternativeControlScheme implements ControlScheme {
  @override
  void handleKeyEvent(RawKeyEvent event) {
    // Implement alternative key event handling
  }
}
