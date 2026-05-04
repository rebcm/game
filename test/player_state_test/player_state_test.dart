import 'package:test/test.dart';
import 'package:game/models/player_state/player_state.dart';

void main() {
  group('PlayerStateMachine', () {
    test('initial state is idle', () {
      final stateMachine = PlayerStateMachine();
      expect(stateMachine.state, PlayerState.idle);
    });

    test('transition to walking', () {
      final stateMachine = PlayerStateMachine();
      stateMachine.transitionToWalking();
      expect(stateMachine.state, PlayerState.walking);
    });

    test('transition to idle', () {
      final stateMachine = PlayerStateMachine();
      stateMachine.transitionToWalking();
      stateMachine.transitionToIdle();
      expect(stateMachine.state, PlayerState.idle);
    });
  });
}
