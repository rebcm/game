import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testes de Integração', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implemente os testes de integração aqui
  });
}
