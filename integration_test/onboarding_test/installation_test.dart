import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate installation guide', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Add validation logic here based on the app's initial state
    expect(find.text('Construção Criativa da Rebeca'), findsOneWidget);
  });
}
