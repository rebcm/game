import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:just_audio/just_audio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify audio playback
    final audioPlayer = AudioPlayer();
    await audioPlayer.setAsset('assets/audio/optimized/music/main_theme.mp3');
    await audioPlayer.play();
    await Future.delayed(const Duration(seconds: 2));
    expect(audioPlayer.playing, true);

    // Verify audio pause
    await audioPlayer.pause();
    await Future.delayed(const Duration(seconds: 1));
    expect(audioPlayer.playing, false);

    // Verify audio stop
    await audioPlayer.stop();
    expect(audioPlayer.playing, false);
  });
}
