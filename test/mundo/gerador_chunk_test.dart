import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/mundo/gerador.dart';

void main() {
  group('GeradorMundo', () {
    test('gerarChunk deve criar chunks de diferentes tamanhos', () {
      final chunkPequeno = GeradorMundo.gerarChunk(0, 0, tamanho: 16);
      final chunkMedio = GeradorMundo.gerarChunk(1, 0, tamanho: 32);
      final chunkGrande = GeradorMundo.gerarChunk(2, 0, tamanho: 64);

      expect(chunkPequeno.blocos.length, lessThan(chunkMedio.blocos.length));
      expect(chunkMedio.blocos.length, lessThan(chunkGrande.blocos.length));
    });

    test('gerarChunk deve lidar com chunks de diferentes complexidades', () {
      final chunkSimples = GeradorMundo.gerarChunk(0, 0, complexidade: 0.1);
      final chunkMedio = GeradorMundo.gerarChunk(1, 0, complexidade: 0.5);
      final chunkComplexo = GeradorMundo.gerarChunk(2, 0, complexidade: 0.9);

      expect(chunkSimples.blocos.where((b) => b.tipo == TipoBloco.grama).length, 
             greaterThan(chunkMedio.blocos.where((b) => b.tipo == TipoBloco.grama).length));
      expect(chunkMedio.blocos.where((b) => b.tipo == TipoBloco.pedra).length, 
             greaterThan(chunkComplexo.blocos.where((b) => b.tipo == TipoBloco.pedra).length));
    });
  });
}
