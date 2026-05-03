import 'package:flutter_test/flutter_test.dart';
import 'package:game/player_movement.dart';
import 'package:mockito/mockito.dart';

class MockPlayerMovement extends Mock implements PlayerMovement {}

void main() {
  group('Player Movement Edge Cases', () {
    late PlayerMovement playerMovement;

    setUp(() {
      playerMovement = MockPlayerMovement();
    });

    test('Instantaneous direction change (180 degrees)', () {
      // Arrange
      when(playerMovement.getDirection()).thenReturn(Vector3(1, 0, 0));
      playerMovement.changeDirection(Vector3(-1, 0, 0));

      // Act
      playerMovement.update();

      // Assert
      verify(playerMovement.getDirection()).called(1);
      expect(playerMovement.getDirection(), Vector3(-1, 0, 0));
    });

    test('Abrupt input interruption (stop)', () {
      // Arrange
      when(playerMovement.getVelocity()).thenReturn(Vector3(1, 0, 0));
      playerMovement.stop();

      // Act
      playerMovement.update();

      // Assert
      verify(playerMovement.getVelocity()).called(1);
      expect(playerMovement.getVelocity(), Vector3(0, 0, 0));
    });

    test('Smooth transition between velocities (acceleration/deceleration)', () {
      // Arrange
      when(playerMovement.getVelocity()).thenReturn(Vector3(1, 0, 0));
      playerMovement.accelerate(Vector3(2, 0, 0));

      // Act
      playerMovement.update();

      // Assert
      verify(playerMovement.getVelocity()).called(1);
      expect(playerMovement.getVelocity(), Vector3(2, 0, 0));
    });
  });
}
