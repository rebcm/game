import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/audio_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('External Interruptions Test', () {
    testWidgets('audio playback interruption by phone call', (tester) async {
      await AudioManager.instance.playAudio('test_audio.mp3');
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      expect(AudioManager.instance.isPlaying, false);
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      expect(AudioManager.instance.isPlaying, true);
    });

    testWidgets('audio playback interruption by alarm', (tester) async {
      await AudioManager.instance.playAudio('test_audio.mp3');
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      expect(AudioManager.instance.isPlaying, false);
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      expect(AudioManager.instance.isPlaying, true);
    });

    testWidgets('audio playback interruption by push notification', (tester) async {
      await AudioManager.instance.playAudio('test_audio.mp3');
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      expect(AudioManager.instance.isPlaying, false);
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      expect(AudioManager.instance.isPlaying, true);
    });
  });
}
