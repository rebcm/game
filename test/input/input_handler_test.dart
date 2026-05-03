import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/input/input_handler.dart';
import 'package:game/player/player_state.dart';

void main() {
  group('InputHandler', () {
    late PlayerState playerState;
    late InputHandler inputHandler;

    setUp(() {
      playerState = PlayerState();
      inputHandler = InputHandler(playerState);
    });

    test('handleKeyEvent updates state to walking', () {
      final event = RawKeyDownEvent(
        data: RawKeyEventDataAndroid(),
        logicalKey: LogicalKeyboardKey.keyW,
      );
      inputHandler.handleKeyEvent(event);
      expect(playerState.state, CharacterState.walking);
    });

    test('handleKeyEvent updates state to idle', () {
      final event = RawKeyUpEvent(
        data: RawKeyEventDataAndroid(),
        logicalKey: LogicalKeyboardKey.keyW,
      );
      inputHandler.handleKeyEvent(event);
      expect(playerState.state, CharacterState.idle);
    });

    test('handleTouchEvent updates state to walking', () {
      final event = TouchEvent(TouchEventType.move);
      inputHandler.handleTouchEvent(event);
      expect(playerState.state, CharacterState.walking);
    });

    test('handleTouchEvent updates state to idle', () {
      final event = TouchEvent(TouchEventType.end);
      inputHandler.handleTouchEvent(event);
      expect(playerState.state, CharacterState.idle);
    });
  });
}
