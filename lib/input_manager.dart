import 'package:flutter/services.dart';

class InputManager {
  final Map<LogicalKeyboardKey, String> _keyActionMap = {};
  final Map<String, Function> _actions = {};

  void mapKeyToAction(LogicalKeyboardKey key, String action) {
    _keyActionMap[key] = action;
  }

  void registerAction(String action, Function callback) {
    _actions[action] = callback;
  }

  Future<void> handleKeyEvent(RawKeyEvent event) async {
    if (event is RawKeyDownEvent) {
      final LogicalKeyboardKey key = event.data.keyCode;
      final String? action = _keyActionMap[key];
      if (action != null && _actions[action] != null) {
        _actions[action]!();
      }
    }
  }

  void performAction(String action) {
    if (_actions[action] != null) {
      _actions[action]!();
    }
  }
}
