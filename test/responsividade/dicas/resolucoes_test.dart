import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testes de responsividade para dicas', () {
    testWidgets('Verificar layout em resoluções mínimas', (tester) async {
      await tester.pumpWidget(MyApp());

      await tester.pumpAndSettle();

      final resolucoesMinimas = [320, 360, 375, 414, 768];

      for (var resolucao in resolucoesMinimas) {
        await tester.binding.setSurfaceSize(Size(resolucao, resolucao * 1.77));
        await tester.pumpAndSettle();

        expect(find.text('Dica'), findsOneWidget);
      }
    });
  });
}
