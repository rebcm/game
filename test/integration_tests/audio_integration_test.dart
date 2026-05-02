import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:just_audio/just_audio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test audio playback', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Assume there's a button to play audio
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify audio playback starts
    final audioPlayer = AudioPlayer();
    expect(await audioPlayer.playing, true);
  });
}
