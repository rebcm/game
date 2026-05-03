import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/input_manager.dart';
import 'package:mockito/mockito.dart';

class MockInputManager extends Mock implements InputManager {}

void main() {
  group('InputManager', () {
    late InputManager inputManager;

    setUp(() {
      inputManager = InputManager();
    });

    test('should handle different keys mapped to the same action', () async {
      const LogicalKeyboardKey key1 = LogicalKeyboardKey.keyA;
      const LogicalKeyboardKey key2 = LogicalKeyboardKey.keyB;
      const String action = 'test_action';

      inputManager.mapKeyToAction(key1, action);
      inputManager.mapKeyToAction(key2, action);

      await inputManager.handleKeyEvent(RawKeyDownEvent(data: RawKeyEventDataAndroid(keyCode: key1.keyId)));
      await inputManager.handleKeyEvent(RawKeyDownEvent(data: RawKeyEventDataAndroid(keyCode: key2.keyId)));

      verify(inputManager.performAction(action)).called(2);
    });
  });
}
