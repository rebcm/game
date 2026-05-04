import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('teste de compreensão da dica', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementação do teste de compreensão da dica
  });

  testWidgets('teste de tempo de leitura da dica', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementação do teste de tempo de leitura
  });

  testWidgets('teste de interação após a dica', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Implementação do teste de interação
  });
}
