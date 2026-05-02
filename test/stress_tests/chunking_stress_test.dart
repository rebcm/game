import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/mundo/chunk.dart';

void main() {
  testWidgets('Stress test para movimentação entre chunks', (tester) async {
    await tester.pumpWidget(MyApp());

    final renderizador = RenderizadorIsometrico();
    final gerador = GeradorMundo();

    for (int i = 0; i < 100; i++) {
      await tester.pump();
      renderizador.atualizarCamera(10, 0);
      await tester.pump();
      gerador.gerarChunk(renderizador.cameraX, renderizador.cameraZ);
      await tester.pump();
    }

    expect(renderizador.chunks.length, greaterThan(0));
  });

  testWidgets('Verifica limpeza de memória de chunks descarregados', (tester) async {
    await tester.pumpWidget(MyApp());

    final renderizador = RenderizadorIsometrico();
    final gerador = GeradorMundo();

    for (int i = 0; i < 100; i++) {
      await tester.pump();
      renderizador.atualizarCamera(10, 0);
      await tester.pump();
      gerador.gerarChunk(renderizador.cameraX, renderizador.cameraZ);
      await tester.pump();
    }

    expect(renderizador.chunksDescarregados.length, equals(0));
  });
}
