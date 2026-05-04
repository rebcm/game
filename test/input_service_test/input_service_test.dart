import 'package:test/test.dart';
import 'package:game/services/input_service/input_service.dart';
import 'package:flutter/material.dart';

void main() {
  group('InputService', () {
    test('is movement key pressed', () {
      final inputService = InputService();
      final event = RawKeyDownEvent(
        data: RawKeyEventDataWindows(),
        character: 'w',
      );
      expect(inputService.isMovementKeyPressed(event), true);
    });

    test('is not movement key pressed', () {
      final inputService = InputService();
      final event = RawKeyDownEvent(
        data: RawKeyEventDataWindows(),
        character: 'e',
      );
      expect(inputService.isMovementKeyPressed(event), false);
    });
  });
}
