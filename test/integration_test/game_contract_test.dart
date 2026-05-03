import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Contract test for game frontend', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Example test: Verify that the game starts with the correct initial screen
    expect(find.text('Construção Criativa da Rebeca'), findsOneWidget);
  });
}
