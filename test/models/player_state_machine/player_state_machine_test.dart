import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/player_state_machine/player_state_machine.dart';

void main() {
  test('PlayerStateMachine should be created', () {
    expect(const PlayerStateMachine.idle(), isA<PlayerStateMachine>());
  });

  test('PlayerStateMachine should have correct state', () {
    expect(const PlayerStateMachine.idle().isIdle, true);
    expect(const PlayerStateMachine.walking().isWalking, true);
    expect(const PlayerStateMachine.stopping().isStopping, true);
  });
}
