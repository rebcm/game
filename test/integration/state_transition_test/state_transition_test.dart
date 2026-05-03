import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('State Transition Tests', () {
    testWidgets('Idle to Walk and back to Idle', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate walk input
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();

      // Verify state transitioned to Walk
      expect(find.text('Walk'), findsOneWidget);

      // Stop walk input
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp, false);
      await tester.pumpAndSettle();

      // Verify state transitioned back to Idle
      expect(find.text('Idle'), findsOneWidget);
    });

    testWidgets('Walk to Run and back to Walk', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate walk input
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();

      // Simulate run input
      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
      await tester.pumpAndSettle();

      // Verify state transitioned to Run
      expect(find.text('Run'), findsOneWidget);

      // Stop run input
      await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
      await tester.pumpAndSettle();

      // Verify state transitioned back to Walk
      expect(find.text('Walk'), findsOneWidget);
    });

    testWidgets('Snap Rotation Test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate snap rotation input
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      // Verify rotation changed
      expect(find.text('Rotated'), findsOneWidget);
    });
  });
}
