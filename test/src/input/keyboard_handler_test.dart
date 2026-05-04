import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/input/keyboard_handler.dart';

void main() {
  group('KeyboardHandler', () {
    test('should ignore specified shortcuts', () {
      final handler = KeyboardHandler();

      expect(handler.shouldIgnoreKey(RawKeyDownEvent(
        data: RawKeyEventDataWindows(
          keyCode: 0x4E, // N
          modifiersDown: {ModifierKey.controlModifier},
        ),
        logicalKey: LogicalKeyboardKey.keyN,
      )), isTrue);

      expect(handler.shouldIgnoreKey(RawKeyDownEvent(
        data: RawKeyEventDataWindows(
          keyCode: 0x54, // T
          modifiersDown: {ModifierKey.controlModifier},
        ),
        logicalKey: LogicalKeyboardKey.keyT,
      )), isTrue);

      expect(handler.shouldIgnoreKey(RawKeyDownEvent(
        data: RawKeyEventDataWindows(
          keyCode: 0x54, // T
          modifiersDown: {ModifierKey.controlModifier, ModifierKey.shiftModifier},
        ),
        logicalKey: LogicalKeyboardKey.keyT,
      )), isTrue);

      expect(handler.shouldIgnoreKey(RawKeyDownEvent(
        data: RawKeyEventDataWindows(
          keyCode: 0x57, // W
          modifiersDown: {ModifierKey.controlModifier},
        ),
        logicalKey: LogicalKeyboardKey.keyW,
      )), isTrue);

      expect(handler.shouldIgnoreKey(RawKeyDownEvent(
        data: RawKeyEventDataWindows(
          keyCode: 0x74, // F5
          modifiersDown: {},
        ),
        logicalKey: LogicalKeyboardKey.f5,
      )), isTrue);
    });
  });
}
