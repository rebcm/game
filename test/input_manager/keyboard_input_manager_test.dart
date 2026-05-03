import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/input_manager/input_command.dart';
import 'package:game/input_manager/keyboard_input_manager.dart';

void main() {
  group('KeyboardInputManager', () {
    late KeyboardInputManager inputManager;

    setUp(() {
      inputManager = KeyboardInputManager();
    });

    test('should handle key down event', () {
      final event = RawKeyDownEvent(
        data: RawKeyEventDataAndroid(),
        logicalKey: LogicalKeyboardKey.keyW,
      );
      inputManager.handleKeyEvent(event);
      expect(inputManager.isCommandPressed(InputCommand.moveForward), isTrue);
    });

    test('should handle key up event', () {
      final downEvent = RawKeyDownEvent(
        data: RawKeyEventDataAndroid(),
        logicalKey: LogicalKeyboardKey.keyW,
      );
      final upEvent = RawKeyUpEvent(
        data: RawKeyEventDataAndroid(),
        logicalKey: LogicalKeyboardKey.keyW,
      );
      inputManager.handleKeyEvent(downEvent);
      inputManager.handleKeyEvent(upEvent);
      expect(inputManager.isCommandPressed(InputCommand.moveForward), isFalse);
    });
  });
}
