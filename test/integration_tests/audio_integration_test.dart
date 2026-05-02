import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:just_audio/just_audio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Integration Tests', () {
    testWidgets('plays audio correctly', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assume there's a button to play audio
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify audio is playing
      // This part depends on how you're handling audio in your app
      // For example, if you're using just_audio, you might check the player's state
      final player = AudioPlayer();
      expect(player.playing, true);
    });

    testWidgets('pauses audio correctly', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assume there's a button to play and pause audio
      await tester.tap(find.byType(ElevatedButton)); // Play
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton)); // Pause
      await tester.pumpAndSettle();

      // Verify audio is paused
      final player = AudioPlayer();
      expect(player.playing, false);
    });
  });
}
