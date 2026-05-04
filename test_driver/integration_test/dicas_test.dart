import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('teste de visualização de dicas', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular a ação de visualizar a dica
    await tester.tap(find.text('Dica'));
    await tester.pumpAndSettle();

    // Verificar se a dica foi exibida
    expect(find.text('Conteúdo da Dica'), findsOneWidget);
  });

  testWidgets('teste de completude da ação', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular a ação de visualizar a dica
    await tester.tap(find.text('Dica'));
    await tester.pumpAndSettle();

    // Simular a ação sugerida pela dica
    await tester.tap(find.text('Ação Sugerida'));
    await tester.pumpAndSettle();

    // Verificar se a ação foi completada
    expect(find.text('Ação Concluída'), findsOneWidget);
  });
}
