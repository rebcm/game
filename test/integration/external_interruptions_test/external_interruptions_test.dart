import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/audio/audio_player.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('External Interruptions Test', () {
    testWidgets('audio playback interruption by phone call', (tester) async {
      // Initialize audio player
      final audioPlayer = AudioPlayer();
      await audioPlayer.play('test_audio.mp3');

      // Simulate phone call interruption
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);

      // Verify audio playback is paused
      expect(audioPlayer.isPlaying, false);

      // Resume app lifecycle
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

      // Verify audio playback resumes
      expect(audioPlayer.isPlaying, true);
    });

    testWidgets('audio playback interruption by alarm', (tester) async {
      // Initialize audio player
      final audioPlayer = AudioPlayer();
      await audioPlayer.play('test_audio.mp3');

      // Simulate alarm interruption
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);

      // Verify audio playback is paused
      expect(audioPlayer.isPlaying, false);

      // Resume app lifecycle
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

      // Verify audio playback resumes
      expect(audioPlayer.isPlaying, true);
    });

    testWidgets('audio playback interruption by push notification', (tester) async {
      // Initialize audio player
      final audioPlayer = AudioPlayer();
      await audioPlayer.play('test_audio.mp3');

      // Simulate push notification interruption
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);

      // Verify audio playback is paused
      expect(audioPlayer.isPlaying, false);

      // Resume app lifecycle
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

      // Verify audio playback resumes
      expect(audioPlayer.isPlaying, true);
    });
  });
}
