import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('documentação deve ser renderizada corretamente', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementar verificações para a documentação
  });

  testWidgets('links da documentação devem ser válidos', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementar verificações para os links da documentação
  });
}
