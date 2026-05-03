import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/audio_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('External Interruptions Test', () {
    testWidgets('audio playback interruption by phone call', (tester) async {
      await AudioManager.instance.playAudio('test_audio.mp3');
      // Simulate phone call interruption
      await AudioManager.instance.onInterruption('phone_call');
      expect(AudioManager.instance.isPlaying, false);
      await AudioManager.instance.resumeAudio();
      expect(AudioManager.instance.isPlaying, true);
    });

    testWidgets('audio playback interruption by alarm', (tester) async {
      await AudioManager.instance.playAudio('test_audio.mp3');
      // Simulate alarm interruption
      await AudioManager.instance.onInterruption('alarm');
      expect(AudioManager.instance.isPlaying, false);
      await AudioManager.instance.resumeAudio();
      expect(AudioManager.instance.isPlaying, true);
    });

    testWidgets('audio playback interruption by push notification', (tester) async {
      await AudioManager.instance.playAudio('test_audio.mp3');
      // Simulate push notification interruption
      await AudioManager.instance.onInterruption('push_notification');
      expect(AudioManager.instance.isPlaying, false);
      await AudioManager.instance.resumeAudio();
      expect(AudioManager.instance.isPlaying, true);
    });
  });
}
