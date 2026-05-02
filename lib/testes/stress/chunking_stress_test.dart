import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de estresse de chunking', (tester) async {
    await tester.pumpWidget(
      RenderizadorIsometrico(
        gerador: GeradorMundo(),
        rebeca: Rebeca(),
      ),
    );

    for (int i = 0; i < 100; i++) {
      await tester.pumpAndSettle(Duration(milliseconds: 16));
      // Simula movimentação rápida
    }

    expect(find.byType(RenderizadorIsometrico), findsOneWidget);
  });
}
