import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Smoke test: Verify Flutter app initialization', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    final flutterPane = find.byType('FlutterView');
    expect(flutterPane, findsOneWidget);
  });
}
