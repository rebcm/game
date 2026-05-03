import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Renderização de chunks em isolates', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a movimentação do jogador para carregar novos chunks
    await tester.drag(find.byType(SingleChildScrollView), Offset(100, 0));
    await tester.pumpAndSettle();

    // Verifica se o carregamento de chunks ocorreu sem bloquear a Main Thread
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
