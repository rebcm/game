import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('interruption test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Start audio playback
    // await tester.tap(find.byType(ElevatedButton)); // Example button to start audio

    // Simulate interruption
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pumpAndSettle();

    // Verify audio state after interruption
    // expect(find.text('Audio paused'), findsOneWidget);

    // Resume app
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    // Verify audio state after resuming
    // expect(find.text('Audio resumed'), findsOneWidget);
  });
}
