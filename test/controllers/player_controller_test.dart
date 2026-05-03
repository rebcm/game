import 'package:flutter_test/flutter_test.dart';
import 'package:game/controllers/player_controller.dart';

void main() {
  group('PlayerController', () {
    test('deve mudar para Walking quando tecla de movimentação for pressionada', () {
      final controller = PlayerController();
      controller.handleInput(KeyboardEvent('W'));
      expect(controller.state, PlayerState.walking);
    });

    test('deve mudar para Walking quando controle de movimentação for acionado', () {
      final controller = PlayerController();
      // Mockar o isMovementControl para retornar true
      controller.handleInput(TouchEvent(Offset.zero));
      expect(controller.state, PlayerState.walking);
    });
  });
}
