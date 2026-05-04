import 'package:test/test.dart';
import 'package:game/controllers/player_controller/player_controller.dart';
import 'package:game/models/player_state/player_state.dart';
import 'package:game/services/input_service/input_service.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockPlayerStateMachine extends Mock implements PlayerStateMachine {}

class MockInputService extends Mock implements InputService {}

void main() {
  group('PlayerController', () {
    test('handle key event - movement key pressed', () {
      final playerStateMachine = MockPlayerStateMachine();
      final inputService = MockInputService();
      final controller = PlayerController(playerStateMachine, inputService);
      final event = RawKeyDownEvent(
        data: RawKeyEventDataWindows(),
        character: 'w',
      );

      when(inputService.isMovementKeyPressed(event)).thenReturn(true);

      controller.handleKeyEvent(event);

      verify(playerStateMachine.transitionToWalking()).called(1);
    });

    test('handle key event - movement key not pressed', () {
      final playerStateMachine = MockPlayerStateMachine();
      final inputService = MockInputService();
      final controller = PlayerController(playerStateMachine, inputService);
      final event = RawKeyDownEvent(
        data: RawKeyEventDataWindows(),
        character: 'e',
      );

      when(inputService.isMovementKeyPressed(event)).thenReturn(false);

      controller.handleKeyEvent(event);

      verify(playerStateMachine.transitionToIdle()).called(1);
    });
  });
}
