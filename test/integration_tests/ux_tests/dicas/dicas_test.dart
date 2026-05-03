import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('UX Dicas Tests', () {
    testWidgets('Dica aparece após ação específica', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simula ação do jogador
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verifica se a dica aparece
      expect(find.text('Dica de construção'), findsOneWidget);
    });

    testWidgets('Dica desaparece após ação seguinte', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simula ação do jogador
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Simula ação seguinte
      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();

      // Verifica se a dica desapareceu
      expect(find.text('Dica de construção'), findsNothing);
    });
  });
}
