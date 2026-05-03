import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/features/player/movement/player_movement.dart';
import 'package:game/src/features/player/movement/player_movement_trigger.dart';

void main() {
  group('PlayerMovement', () {
    late PlayerMovement playerMovement;

    setUp(() {
      playerMovement = PlayerMovement();
    });

    test('initial state is idle', () {
      expect(playerMovement.state, const PlayerState.idle());
    });

    test('handleInput changes state to walking on valid input', () {
      playerMovement.handleInput('arrowUp');
      expect(playerMovement.state, PlayerState.walking(direction: PlayerMovementTrigger.arrowUp));
    });

    test('handleInput changes state to idle on invalid input', () {
      playerMovement.handleInput('invalidInput');
      expect(playerMovement.state, const PlayerState.idle());
    });
  });
}
