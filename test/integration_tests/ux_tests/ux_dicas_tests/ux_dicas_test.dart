import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('UX dicas test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Cenário 1: Verificar se as dicas aparecem corretamente
    await tester.tap(find.text('Iniciar'));
    await tester.pumpAndSettle();
    expect(find.text('Dica 1'), findsOneWidget);

    // Cenário 2: Verificar se as dicas são acessíveis
    await tester.tap(find.text('Próximo'));
    await tester.pumpAndSettle();
    expect(find.text('Dica 2'), findsOneWidget);

    // Cenário 3: Verificar se as dicas são úteis
    await tester.tap(find.text('Concluir'));
    await tester.pumpAndSettle();
    expect(find.text('Dica 3'), findsNothing);
  });
}
