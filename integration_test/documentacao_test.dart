import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testes de integração da documentação', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implementar os passos de teste manuais rigorosos com evidências obrigatórias
    // conforme descrito na documentação.

    // Exemplo de teste
    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();
    expect(find.text('Bloco criado'), findsOneWidget);
  });
}

