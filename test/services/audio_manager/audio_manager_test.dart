import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager/audio_manager.dart';

void main() {
  group('AudioManager', () {
    test('should be a singleton', () {
      final instance1 = AudioManager();
      final instance2 = AudioManager();
      expect(instance1, instance2);
    });

    test('should play and stop sound', () async {
      final audioManager = AudioManager();
      await audioManager.init();
      await audioManager.playSound('assets/audio/optimized/test.mp3');
      expect(audioManager.isPlaying, true);
      await audioManager.stopSound();
      expect(audioManager.isPlaying, false);
    });

    test('should set and get volume', () async {
      final audioManager = AudioManager();
      await audioManager.init();
      await audioManager.setVolume(0.5);
      expect(audioManager.getVolume(), 0.5);
    });

    test('should dispose', () async {
      final audioManager = AudioManager();
      await audioManager.init();
      await audioManager.dispose();
      expect(() async => await audioManager.playSound('assets/audio/optimized/test.mp3'), throwsA(isA<Exception>()));
    });
  });
}
