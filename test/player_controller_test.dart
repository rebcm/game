import 'package:flutter_test/flutter_test.dart';
import 'package:game/player/player_controller.dart';

void main() {
  group('PlayerController', () {
    test('should change state to walking when key is pressed', () {
      final controller = PlayerController();
      controller.handleKeyPress(RawKeyDownEvent(
        data: RawKeyEventDataWindows(
          keyCode: 87, // 'W' key code
        ),
      ));
      expect(controller.isWalking, true);
    });

    test('should change state to idle when key is released', () {
      final controller = PlayerController();
      controller.handleKeyPress(RawKeyUpEvent(
        data: RawKeyEventDataWindows(
          keyCode: 87, // 'W' key code
        ),
      ));
      expect(controller.isWalking, false);
    });
  });
}
