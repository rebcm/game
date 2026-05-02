import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  testWidgets('Teste de stress de input', (tester) async {
    await tester.pumpWidget(Rebeca());
    final rebeca = tester.widget<Rebeca>(find.byType(Rebeca));

    // Simula mudança brusca de velocidade
    rebeca.mudarVelocidade(0);
    await tester.pump();
    rebeca.mudarVelocidade(100);
    await tester.pump();

    // Verifica se houve glitches visuais
    final renderizador = tester.widget<RenderizadorIsometrico>(find.byType(RenderizadorIsometrico));
    expect(renderizador.estado, isNot(contains('glitch')));
  });
}
