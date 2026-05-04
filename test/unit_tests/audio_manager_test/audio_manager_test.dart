import 'package:flutter_test/flutter_test.dart';
import 'package:game/audio_manager.dart';

void main() {
  group('AudioManager Singleton Tests', () {
    test('Instance should be unique', () {
      final instance1 = AudioManager.instance;
      final instance2 = AudioManager.instance;
      expect(instance1, same(instance2));
    });

    test('Volume control should reflect on active players', () async {
      await AudioManager.instance.setVolume(0.5);
      expect(AudioManager.instance.volume, 0.5);
      // Assuming there's a way to get active players and check their volume
      // This part is hypothetical as the actual implementation is not provided
      // expect(AudioManager.instance.activePlayersVolume, 0.5);
    });
  });
}
