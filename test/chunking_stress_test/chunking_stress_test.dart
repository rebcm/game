import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/mundo/mundo.dart';

void main() {
  testWidgets('Stress test para movimentação rápida entre chunks',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final mundo = Mundo(GeradorMundo());
    await mundo.inicializar();

    final renderizador = RenderizadorIsometrico(mundo);

    for (var i = 0; i < 100; i++) {
      mundo.atualizar(0.01);
      renderizador.renderizar();
      await tester.pump();
    }

    expect(mundo.chunksCarregados, isNotEmpty);
  });
}
