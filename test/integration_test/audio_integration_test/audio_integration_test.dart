import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio playback test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test audio playback
    await tester.tap(find.byKey(Key('audio_play_button')));
    await tester.pumpAndSettle();
    expect(find.text('Audio is playing'), findsOneWidget);

    // Test audio pause
    await tester.tap(find.byKey(Key('audio_pause_button')));
    await tester.pumpAndSettle();
    expect(find.text('Audio is paused'), findsOneWidget);

    // Test audio stop
    await tester.tap(find.byKey(Key('audio_stop_button')));
    await tester.pumpAndSettle();
    expect(find.text('Audio is stopped'), findsOneWidget);
  });

  testWidgets('Audio edge cases test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test audio playback multiple times
    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byKey(Key('audio_play_button')));
      await tester.pumpAndSettle();
      expect(find.text('Audio is playing'), findsOneWidget);
      await tester.tap(find.byKey(Key('audio_stop_button')));
      await tester.pumpAndSettle();
    }

    // Test audio pause multiple times
    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byKey(Key('audio_play_button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('audio_pause_button')));
      await tester.pumpAndSettle();
      expect(find.text('Audio is paused'), findsOneWidget);
      await tester.tap(find.byKey(Key('audio_stop_button')));
      await tester.pumpAndSettle();
    }
  });
}
