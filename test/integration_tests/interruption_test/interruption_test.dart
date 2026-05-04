import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test interruption during audio playback', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate audio playback
    await tester.tap(find.byKey(Key('audio_playback_button')));
    await tester.pumpAndSettle();

    // Simulate interruption
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pumpAndSettle();

    // Verify audio playback is paused
    expect(find.text('Audio paused'), findsOneWidget);

    // Simulate resume
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    // Verify audio playback is resumed
    expect(find.text('Audio playing'), findsOneWidget);
  });
}
