import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testes de responsividade em telas pequenas', () {
    testWidgets('Verificar wrap e truncamento de dicas em largura inferior a 320dp', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(280, 800)); // Largura inferior a 320dp
      await tester.pumpAndSettle();

      final dicaFinder = find.text('Dica de teste');
      expect(dicaFinder, findsOneWidget);

      final dicaWidget = tester.widget<Text>(dicaFinder);
      expect(dicaWidget.text, isNot(contains('...')));
      expect(dicaWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
