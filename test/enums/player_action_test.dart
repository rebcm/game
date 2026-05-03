import 'package:flutter_test/flutter_test.dart';
import 'package:game/enums/player_action.dart';

void main() {
  test('PlayerAction enum values are correctly defined', () {
    expect(PlayerAction.values.length, 5); // Update this count as you add more actions
    expect(PlayerAction.moveForward.toString(), 'PlayerAction.moveForward');
    expect(PlayerAction.moveBackward.toString(), 'PlayerAction.moveBackward');
    expect(PlayerAction.moveLeft.toString(), 'PlayerAction.moveLeft');
    expect(PlayerAction.moveRight.toString(), 'PlayerAction.moveRight');
    expect(PlayerAction.jump.toString(), 'PlayerAction.jump');
  });
}
