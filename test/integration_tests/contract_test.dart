import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Contract test for frontend changes', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Add contract test logic here
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
