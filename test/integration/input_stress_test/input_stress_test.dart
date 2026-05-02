import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Input Stress Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate high-frequency input
    for (int i = 0; i < 100; i++) {
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
    }

    // Verify animation controller response
    expect(find.byType(AnimatedBuilder), findsOneWidget);
  });
}
