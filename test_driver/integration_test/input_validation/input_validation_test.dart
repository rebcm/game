import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Input Validation Tests', () {
    testWidgets('Simultaneous keyboard and touch input test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate keyboard input
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      // Simulate touch input
      await tester.tapAt(Offset(100, 100));
      await tester.pumpAndSettle();

      // Verify the expected outcome
      expect(find.text('Expected outcome'), findsOneWidget);
    });
  });
}
import 'input_validation/fixtures/input_scenarios.dart';

void main() {
  // ...

  group('Input Validation Tests', () {
    InputScenarios.scenarios.forEach((scenario) {
      testWidgets('Simultaneous input test: ${scenario['keyboardInput']} + ${scenario['touchInput']}', (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.sendKeyEvent(scenario['keyboardInput']);
        await tester.pumpAndSettle();

        await tester.tapAt(scenario['touchInput']);
        await tester.pumpAndSettle();

        expect(find.text(scenario['expectedOutcome']), findsOneWidget);
      });
    });
  });
}
