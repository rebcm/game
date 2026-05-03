import 'package:flutter_test/flutter_test.dart';
import 'package:game/player/player.dart';

void main() {
  group('Player State Transition Tests', () {
    late Player player;

    setUp(() {
      player = Player();
    });

    test('Idle to Walk transition is smooth', () {
      player.idle();
      expect(player.state, PlayerState.idle);
      player.walk();
      expect(player.state, PlayerState.walk);
    });

    test('Walk to Run transition is smooth', () {
      player.walk();
      expect(player.state, PlayerState.walk);
      player.run();
      expect(player.state, PlayerState.run);
    });

    test('Idle to Run transition is smooth', () {
      player.idle();
      expect(player.state, PlayerState.idle);
      player.run();
      expect(player.state, PlayerState.run);
    });

    test('Run to Walk transition is smooth', () {
      player.run();
      expect(player.state, PlayerState.run);
      player.walk();
      expect(player.state, PlayerState.walk);
    });

    test('Walk to Idle transition is smooth', () {
      player.walk();
      expect(player.state, PlayerState.walk);
      player.idle();
      expect(player.state, PlayerState.idle);
    });

    test('Run to Idle transition is smooth', () {
      player.run();
      expect(player.state, PlayerState.run);
      player.idle();
      expect(player.state, PlayerState.idle);
    });
  });
}
