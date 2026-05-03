import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Concurrency Tests', () {
    test('should play multiple sounds simultaneously without errors', () async {
      final audioManager = AudioManager();
      await audioManager.initAudio();
      for (var i = 0; i < 10; i++) {
        await audioManager.playSound('placeholder_sfx.mp3');
      }
      await Future.delayed(const Duration(seconds: 1));
      expect(audioManager.isPlaying, true);
    });

    test('should handle missing audio files gracefully', () async {
      final audioManager = AudioManager();
      await audioManager.initAudio();
      await audioManager.playSound('non_existent_sound.mp3');
      await Future.delayed(const Duration(seconds: 1));
      expect(audioManager.isPlaying, false);
    });

    test('should handle corrupted audio files gracefully', () async {
      final audioManager = AudioManager();
      await audioManager.initAudio();
      await audioManager.playSound('corrupted_sound.mp3');
      await Future.delayed(const Duration(seconds: 1));
      expect(audioManager.isPlaying, false);
    });
  });
}
