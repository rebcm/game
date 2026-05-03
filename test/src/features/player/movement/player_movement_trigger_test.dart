import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/features/player/movement/player_movement_trigger.dart';

void main() {
  group('PlayerMovementTriggerHandler', () {
    test('isMovementTrigger returns true for valid inputs', () {
      expect(PlayerMovementTriggerHandler.isMovementTrigger('arrowUp'), true);
      expect(PlayerMovementTriggerHandler.isMovementTrigger('keyW'), true);
    });

    test('isMovementTrigger returns false for invalid inputs', () {
      expect(PlayerMovementTriggerHandler.isMovementTrigger('invalidInput'), false);
    });

    test('fromInput returns correct trigger for valid inputs', () {
      expect(PlayerMovementTriggerHandler.fromInput('arrowUp'), PlayerMovementTrigger.arrowUp);
      expect(PlayerMovementTriggerHandler.fromInput('keyW'), PlayerMovementTrigger.keyW);
    });

    test('fromInput returns null for invalid inputs', () {
      expect(PlayerMovementTriggerHandler.fromInput('invalidInput'), null);
    });
  });
}
