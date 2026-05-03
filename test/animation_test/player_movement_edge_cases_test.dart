import 'package:flutter_test/flutter_test.dart';
import 'package:game/animation/player_movement.dart';

void main() {
  group('PlayerMovement', () {
    test('should handle contradictory inputs', () {
      final playerMovement = PlayerMovement();
      playerMovement.updateDirection(1, 0);
      playerMovement.updateDirection(-1, 0);
      expect(playerMovement.velocity.x, 0);
    });

    test('should handle 180-degree direction change', () {
      final playerMovement = PlayerMovement();
      playerMovement.updateDirection(1, 0);
      playerMovement.updateDirection(-1, 0);
      expect(playerMovement.velocity.x, 0);
    });
  });
}
