import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio playback test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test audio playback
    await tester.tap(find.byKey(Key('audio_playback_button')));
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

    // Test audio playback with invalid file
    await tester.tap(find.byKey(Key('audio_playback_invalid_file_button')));
    await tester.pumpAndSettle();
    expect(find.text('Error playing audio'), findsOneWidget);

    // Test audio playback with null file
    await tester.tap(find.byKey(Key('audio_playback_null_file_button')));
    await tester.pumpAndSettle();
    expect(find.text('Error playing audio'), findsOneWidget);
  });
}
