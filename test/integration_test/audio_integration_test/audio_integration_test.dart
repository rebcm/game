import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio playback test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test audio playback
    await tester.tap(find.byTooltip('Play Audio'));
    await tester.pumpAndSettle();
    expect(find.text('Audio playing'), findsOneWidget);

    // Test audio pause
    await tester.tap(find.byTooltip('Pause Audio'));
    await tester.pumpAndSettle();
    expect(find.text('Audio paused'), findsOneWidget);

    // Test audio stop
    await tester.tap(find.byTooltip('Stop Audio'));
    await tester.pumpAndSettle();
    expect(find.text('Audio stopped'), findsOneWidget);
  });

  testWidgets('Audio edge cases test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test audio playback multiple times
    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byTooltip('Play Audio'));
      await tester.pumpAndSettle();
      expect(find.text('Audio playing'), findsOneWidget);
      await tester.tap(find.byTooltip('Stop Audio'));
      await tester.pumpAndSettle();
    }

    // Test audio pause and resume
    await tester.tap(find.byTooltip('Play Audio'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Pause Audio'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Resume Audio'));
    await tester.pumpAndSettle();
    expect(find.text('Audio playing'), findsOneWidget);
  });
}
