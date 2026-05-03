import 'package:flutter_test/flutter_test.dart';
import 'package:game/player_state_machine.dart';

void main() {
  group('PlayerStateMachine', () {
    late PlayerStateMachine stateMachine;

    setUp(() {
      stateMachine = PlayerStateMachine();
    });

    test('starts in Idle state', () {
      expect(stateMachine.currentState, PlayerState.idle);
    });

    test('transitions from Idle to Walk on input', () {
      stateMachine.handleInput(PlayerInput.walk);
      expect(stateMachine.currentState, PlayerState.walk);
    });

    test('transitions from Walk to Run on input', () {
      stateMachine.handleInput(PlayerInput.walk);
      stateMachine.handleInput(PlayerInput.run);
      expect(stateMachine.currentState, PlayerState.run);
    });

    test('transitions from Run to Walk on input change', () {
      stateMachine.handleInput(PlayerInput.run);
      stateMachine.handleInput(PlayerInput.walk);
      expect(stateMachine.currentState, PlayerState.walk);
    });

    test('transitions from Walk to Idle on input cessation', () {
      stateMachine.handleInput(PlayerInput.walk);
      stateMachine.handleInput(PlayerInput.none);
      expect(stateMachine.currentState, PlayerState.idle);
    });

    test('transitions from Run to Idle on input cessation', () {
      stateMachine.handleInput(PlayerInput.run);
      stateMachine.handleInput(PlayerInput.none);
      expect(stateMachine.currentState, PlayerState.idle);
    });
  });
}
