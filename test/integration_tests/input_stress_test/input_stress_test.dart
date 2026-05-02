import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('input stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate input stress by rapidly changing the speed
    await tester.tap(find.byKey(Key('speed_control')));
    await tester.pump(Duration(milliseconds: 100));
    await tester.tap(find.byKey(Key('max_speed_button')));
    await tester.pump(Duration(milliseconds: 100));
    await tester.tap(find.byKey(Key('min_speed_button')));
    await tester.pump(Duration(milliseconds: 100));

    // Verify that there are no visual glitches
    await expectLater(find.byType(app.RebecaGame), matchesGoldenFile('input_stress_test_golden.png'));
  });
}
