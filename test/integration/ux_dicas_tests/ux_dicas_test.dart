import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('UX Dicas Tests', () {
    testWidgets('Dicas aparecem quando esperado', (tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Simula interação do usuário
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verifica se a dica aparece
      expect(find.text('Dica: Utilize o menu para selecionar blocos'), findsOneWidget);
    });

    testWidgets('Dicas são acessíveis e úteis', (tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Simula interação do usuário
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verifica se a dica é acessível
      expect(find.text('Dica: Selecione um bloco para construir'), findsOneWidget);
      expect(tester.getSize(find.text('Dica: Selecione um bloco para construir')).height).isPositive;
    });

    testWidgets('Fluxo de interação com dicas', (tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Simula interação do usuário
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verifica o fluxo de dicas
      expect(find.text('Dica: Utilize o menu para selecionar blocos'), findsNothing);
      expect(find.text('Dica: Selecione um bloco para construir'), findsOneWidget);
    });
  });
}
