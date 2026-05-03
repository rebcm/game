import 'package:flutter_test/flutter_test.dart';
import 'package:game/controllers/player_controller/player_controller.dart';

void main() {
  test('PlayerController should change state', () {
    final controller = PlayerController();
    controller.startWalking();
    expect(controller.state.isWalking, true);
    controller.stopWalking();
    expect(controller.state.isStopping, true);
    controller.stop();
    expect(controller.state.isIdle, true);
  });
}
