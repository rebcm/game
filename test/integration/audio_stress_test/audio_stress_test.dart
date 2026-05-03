import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/audio_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Stress Test', () {
    testWidgets('should play multiple sounds simultaneously without crashing', (tester) async {
      final audioManager = AudioManager();
      for (var i = 0; i < 10; i++) {
        await audioManager.playSound('valid_sound.mp3');
      }
      await Future.delayed(const Duration(seconds: 2));
      expect(audioManager.isPlaying, true);
    });

    testWidgets('should handle missing audio files gracefully', (tester) async {
      final audioManager = AudioManager();
      await audioManager.playSound('missing_sound.mp3');
      await Future.delayed(const Duration(seconds: 1));
      expect(audioManager.isPlaying, false);
    });

    testWidgets('should handle corrupted audio files gracefully', (tester) async {
      final audioManager = AudioManager();
      await audioManager.playSound('corrupted_sound.mp3');
      await Future.delayed(const Duration(seconds: 1));
      expect(audioManager.isPlaying, false);
    });
  });
}
