import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/audio/audio_player.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('External Interruptions Test', () {
    testWidgets('audio playback interruption test', (tester) async {
      await AudioPlayer.instance.play('test_audio.mp3');
      await Future.delayed(const Duration(seconds: 2));
      // Simulate incoming call
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      expect(AudioPlayer.instance.isPlaying, false);
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      // No need to restart playback as per the task description
    });

    testWidgets('audio playback alarm interruption test', (tester) async {
      await AudioPlayer.instance.play('test_audio.mp3');
      await Future.delayed(const Duration(seconds: 2));
      // Simulate alarm
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      expect(AudioPlayer.instance.isPlaying, false);
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      // No need to restart playback as per the task description
    });
  });
}
