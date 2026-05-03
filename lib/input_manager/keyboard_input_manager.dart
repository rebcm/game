import 'package:flutter/services.dart';
import 'input_command.dart';
import 'input_manager.dart';

class KeyboardInputManager implements InputManager {
  final Map<InputCommand, bool> _commandPressed = {};
  final Map<LogicalKeyboardKey, InputCommand> _keyBindings = {
    LogicalKeyboardKey.keyW: InputCommand.moveForward,
    LogicalKeyboardKey.keyS: InputCommand.moveBackward,
    LogicalKeyboardKey.keyA: InputCommand.moveLeft,
    LogicalKeyboardKey.keyD: InputCommand.moveRight,
    LogicalKeyboardKey.space: InputCommand.jump,
    LogicalKeyboardKey.keyF: InputCommand.toggleFlyMode,
  };

  @override
  void handleKeyEvent(RawKeyEvent event) {
    final key = event.logicalKey;
    final command = _keyBindings[key];
    if (command != null) {
      _commandPressed[command] = event is RawKeyDownEvent;
    }
  }

  @override
  bool isCommandPressed(InputCommand command) {
    return _commandPressed[command] ?? false;
  }

  @override
  void update() {}
}
