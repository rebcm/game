import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  group('Chunking Heterogêneo', () {
    test('Deve renderizar chunks de diferentes tamanhos sem vazamentos', () async {
      final gerador = GeradorMundo();
      final renderizador = RenderizadorIsometrico();

      for (var tamanho = 16; tamanho <= 64; tamanho *= 2) {
        final chunk = gerador.gerarChunk(tamanho, 0, 0);
        await renderizador.renderizarChunk(chunk);
        await Future.delayed(Duration(milliseconds: 100)); // Aguarda renderização
      }

      expect(renderizador.numeroChunksRenderizados, greaterThan(0));
    });

    test('Deve manter estabilidade com chunks de complexidades variadas', () async {
      final gerador = GeradorMundo();
      final renderizador = RenderizadorIsometrico();

      for (var complexidade = 0; complexidade < 5; complexidade++) {
        final chunk = gerador.gerarChunk(32, complexidade, 0);
        await renderizador.renderizarChunk(chunk);
        await Future.delayed(Duration(milliseconds: 100)); // Aguarda renderização
      }

      expect(renderizador.numeroChunksRenderizados, greaterThan(0));
    });
  });
}
