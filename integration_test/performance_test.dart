import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Performance test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final finder = find.byType(Rebeca);
    expect(finder, findsOneWidget);

    await tester.pump(const Duration(seconds: 5));

    expect(tester.binding.hasPendingMicrotasks, isFalse);
  });
}
