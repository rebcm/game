import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Contract testing for frontend', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Add contract tests here
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
