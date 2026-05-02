import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('input stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate rapid input changes
    await tester.pump(const Duration(milliseconds: 100));
    await tester.drag(find.byType(GestureDetector), const Offset(100, 0));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.drag(find.byType(GestureDetector), const Offset(-100, 0));
    await tester.pump(const Duration(milliseconds: 100));

    // Verify no glitches
    expect(find.byType(GestureDetector), findsOneWidget);
  });
}
