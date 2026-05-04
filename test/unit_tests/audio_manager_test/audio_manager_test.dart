import 'package:flutter_test/flutter_test.dart';
import 'package:game/audio_manager.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioManager Singleton Tests', () {
    test('Instance should be the same', () {
      final instance1 = AudioManager.instance;
      final instance2 = AudioManager.instance;
      expect(instance1, same(instance2));
    });

    test('Volume control should reflect on active players', () async {
      final audioManager = AudioManager.instance;
      await audioManager.setVolume(0.5);

      // Simulate active players
      final player1 = AudioPlayer();
      final player2 = AudioPlayer();
      await player1.play(AssetSource('audio/test.mp3'));
      await player2.play(AssetSource('audio/test.mp3'));

      audioManager.registerPlayer(player1);
      audioManager.registerPlayer(player2);

      await audioManager.setVolume(0.8);

      expect(await player1.getVolume(), closeTo(0.8, 0.01));
      expect(await player2.getVolume(), closeTo(0.8, 0.01));

      await player1.stop();
      await player2.stop();
    });
  });
}
