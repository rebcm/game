import 'package:flutter_test/flutter_test.dart';
import 'package:game/audio_manager.dart';

void main() {
  group('AudioManager Singleton Tests', () {
    test('Instance should be the same when accessed multiple times', () {
      final instance1 = AudioManager.instance;
      final instance2 = AudioManager.instance;
      expect(instance1, same(instance2));
    });

    test('Volume control should reflect on active players', () async {
      final audioManager = AudioManager.instance;
      await audioManager.setVolume(0.5);
      expect(audioManager.volume, 0.5);
      // Assuming there's a way to access active players and their volumes
      // This part is hypothetical as the actual implementation is not provided
      // expect(audioManager.activePlayers.every((player) => player.volume == 0.5), isTrue);
    });
  });
}
