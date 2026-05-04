import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/mundo_estado.dart';

void main() {
  group('MundoEstado', () {
    test('deve serializar e desserializar corretamente', () {
      final mundoEstado = MundoEstado(
        posicaoJogador: PosicaoJogador(x: 1.0, y: 2.0, z: 3.0),
        blocosMundo: [
          Chunk(
            chunkId: 'chunk1',
            blocos: [
              [
                [1, 2, 3],
                [4, 5, 6],
                [7, 8, 9]
              ]
            ],
          ),
        ],
        metadadosMundo: MetadadosMundo(tamanhoMundo: [10, 10, 10], versaoSchema: '1.0'),
      );

      final json = mundoEstado.toJson();
      final novoMundoEstado = MundoEstado.fromJson(json);

      expect(novoMundoEstado, mundoEstado);
    });
  });
}
