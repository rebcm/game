import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('input stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate multiple inputs
    await tester.pumpAndSettle(Duration(milliseconds: 100));
    await tester.drag(find.byType(GestureDetector), Offset(100, 100));
    await tester.pumpAndSettle(Duration(milliseconds: 100));
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle(Duration(milliseconds: 100));

    // Verify the app is still responsive
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
