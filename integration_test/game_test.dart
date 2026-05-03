import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Contract Testing', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implement contract testing logic here
    // For example, verify that the app starts correctly
    expect(find.text('Construção Criativa da Rebeca'), findsOneWidget);
  });
}
