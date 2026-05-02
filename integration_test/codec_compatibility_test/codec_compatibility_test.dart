import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Codec Compatibility Test', () {
    testWidgets('Test .ogg playback', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      final player = AudioPlayer();
      await player.setAsset('assets/audio/optimized/sfx/click.ogg');
      await player.play();
      await Future.delayed(const Duration(seconds: 1));
      expect(player.playing, true);
      await player.stop();
    });

    testWidgets('Test .mp3 playback', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      final player = AudioPlayer();
      await player.setAsset('assets/audio/optimized/sfx/click.mp3');
      await player.play();
      await Future.delayed(const Duration(seconds: 1));
      expect(player.playing, true);
      await player.stop();
    });
  });
}
