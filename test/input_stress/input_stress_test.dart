import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  testWidgets('Teste de stress de input', (tester) async {
    await tester.pumpWidget(Rebeca());

    final rebeca = tester.widget<Rebeca>(find.byType(Rebeca));

    // Simula mudança brusca de velocidade
    rebeca.controller.velocidade = 0;
    await tester.pump();
    rebeca.controller.velocidade = 10;
    await tester.pump();

    expect(rebeca.controller.velocidade, 10);
  });
}
