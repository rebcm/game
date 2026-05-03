import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('audio interruption test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Start playing audio
    // await tester.tap(find.byType(FloatingActionButton));
    // await tester.pumpAndSettle();

    // Simulate incoming call or alarm
    // await tester.binding.handlePhoneCallInterruption();
    // await tester.pumpAndSettle();

    // Verify audio playback is paused
    // expect(find.text('Audio paused'), findsOneWidget);

    // Resume audio playback after interruption
    // await tester.binding.resumeAfterInterruption();
    // await tester.pumpAndSettle();

    // Verify audio playback is resumed
    // expect(find.text('Audio playing'), findsOneWidget);
  });
}
