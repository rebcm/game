import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Input Stress Test', () {
    testWidgets('Multiple simultaneous direction inputs', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate multiple direction inputs
      await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowUp);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      // Verify animation behavior
      expect(find.text('Rebeca'), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowUp);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();
    });

    testWidgets('Sudden angle changes', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate sudden angle change
      await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      // Verify animation behavior
      expect(find.text('Rebeca'), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowLeft);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();
    });
  });
}
