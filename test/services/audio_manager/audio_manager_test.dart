import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager/audio_manager.dart';

void main() {
  group('AudioManager', () {
    test('Singleton instance', () {
      final instance1 = AudioManager();
      final instance2 = AudioManager();
      expect(instance1, instance2);
    });

    test('Play, pause, stop', () async {
      final audioManager = AudioManager();
      await audioManager.play('assets/audio/optimized/music/track.mp3');
      expect(audioManager.isPlaying, true);
      await audioManager.pause();
      expect(audioManager.isPlaying, false);
      await audioManager.stop();
      expect(audioManager.isPlaying, false);
      expect(audioManager.currentTrack, null);
    });

    test('Volume control', () async {
      final audioManager = AudioManager();
      await audioManager.setVolume(0.5);
      expect(audioManager.volume, 0.5);
    });
  });
}
