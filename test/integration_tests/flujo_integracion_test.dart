import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testar fluxo de integração da UI', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular interação com a UI
    await tester.tap(find.text('Botão de Ajuda'));
    await tester.pumpAndSettle();

    expect(find.text('Tela de Dicas'), findsOneWidget);
  });
}
