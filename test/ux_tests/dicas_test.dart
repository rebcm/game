import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  group('Dicas UX Tests', () {
    testWidgets('Verifica se as dicas aparecem corretamente', (tester) async {
      await tester.pumpWidget(MyApp());

      // Simula a interação do usuário
      await tester.tap(find.text('Novo Bloco'));
      await tester.pumpAndSettle();

      // Verifica se a dica aparece
      expect(find.text('Dica: Use o botão para criar um novo bloco'), findsOneWidget);
    });

    testWidgets('Verifica se as dicas são acessíveis', (tester) async {
      await tester.pumpWidget(MyApp());

      // Simula a navegação até a dica
      await tester.tap(find.text('Novo Bloco'));
      await tester.pumpAndSettle();

      // Verifica se a dica é acessível
      expect(find.text('Dica: Use o botão para criar um novo bloco'), findsOneWidget);
      expect(tester.getSemantics(find.text('Dica: Use o botão para criar um novo bloco')), isNotNull);
    });

    testWidgets('Verifica o fluxo de interação das dicas', (tester) async {
      await tester.pumpWidget(MyApp());

      // Simula a interação do usuário com as dicas
      await tester.tap(find.text('Novo Bloco'));
      await tester.pumpAndSettle();

      // Verifica se a próxima dica aparece após a interação
      await tester.tap(find.text('Próximo'));
      await tester.pumpAndSettle();

      expect(find.text('Dica: Use o botão para editar um bloco'), findsOneWidget);
    });
  });
}
