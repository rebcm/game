import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:just_audio/just_audio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test audio codec compatibility', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final player = AudioPlayer();
    await player.setAsset('assets/audio/optimized/ambient/test.ogg');
    await player.play();
    await Future.delayed(Duration(seconds: 2));
    await player.stop();

    await player.setAsset('assets/audio/optimized/music/test.mp3');
    await player.play();
    await Future.delayed(Duration(seconds: 2));
    await player.stop();
  });
}
