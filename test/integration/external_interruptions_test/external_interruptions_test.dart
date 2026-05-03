import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/audio/audio_player.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('External Interruptions Test', () {
    testWidgets('audio playback interruption test', (tester) async {
      final audioPlayer = AudioPlayer();
      await audioPlayer.play('test_audio.mp3');
      await tester.pumpAndSettle();
      // Simulate phone call interruption
      await audioPlayer.pause();
      expect(audioPlayer.isPlaying, false);
      await audioPlayer.resume();
      expect(audioPlayer.isPlaying, true);
    });

    testWidgets('audio playback alarm interruption test', (tester) async {
      final audioPlayer = AudioPlayer();
      await audioPlayer.play('test_audio.mp3');
      await tester.pumpAndSettle();
      // Simulate alarm interruption
      await audioPlayer.pause();
      expect(audioPlayer.isPlaying, false);
      await audioPlayer.resume();
      expect(audioPlayer.isPlaying, true);
    });

    testWidgets('audio playback notification interruption test', (tester) async {
      final audioPlayer = AudioPlayer();
      await audioPlayer.play('test_audio.mp3');
      await tester.pumpAndSettle();
      // Simulate notification interruption
      await audioPlayer.pause();
      expect(audioPlayer.isPlaying, false);
      await audioPlayer.resume();
      expect(audioPlayer.isPlaying, true);
    });
  });
}
