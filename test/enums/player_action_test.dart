import 'package:flutter_test/flutter_test.dart';
import 'package:game/enums/player_action.dart';

void main() {
  test('PlayerAction enum values are correct', () {
    expect(PlayerAction.values.length, 5); // Update the expected length as you add more actions
    expect(PlayerAction.moveForward.index, 0);
    expect(PlayerAction.moveBackward.index, 1);
    expect(PlayerAction.moveLeft.index, 2);
    expect(PlayerAction.moveRight.index, 3);
    expect(PlayerAction.jump.index, 4);
  });
}
