import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Stress Test', () {
    late AudioManager audioManager;

    setUp(() {
      audioManager = AudioManager();
    });

    test('should play multiple sounds simultaneously without crashing', () async {
      for (int i = 0; i < 10; i++) {
        await audioManager.playSound('sfx/sound.mp3');
      }
      await Future.delayed(Duration(seconds: 2));
      expect(audioManager.player.playing, true);
    });

    test('should handle missing audio files gracefully', () async {
      await audioManager.playSound('sfx/non_existent_sound.mp3');
      await Future.delayed(Duration(seconds: 1));
      expect(audioManager.player.playing, false);
    });

    test('should handle corrupted audio files gracefully', () async {
      await audioManager.playSound('sfx/corrupted_sound.mp3');
      await Future.delayed(Duration(seconds: 1));
      expect(audioManager.player.playing, false);
    });
  });
}
