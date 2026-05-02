import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/player/rebeca_player.dart';

void main() {
  group('RebecaPlayer', () {
    test('initialization', () {
      final player = RebecaPlayer();
      expect(player.size, Vector2(1, 2));
    });

    test('movement', () {
      final player = RebecaPlayer();
      player.move(Vector2(1, 0));
      // Verify movement logic
    });

    test('jump', () {
      final player = RebecaPlayer();
      player.jump();
      // Verify jump logic
    });

    test('fly', () {
      final player = RebecaPlayer();
      player.fly();
      // Verify fly logic
    });

    test('interact', () {
      final player = RebecaPlayer();
      player.interact();
      // Verify interaction logic
    });
  });
}
