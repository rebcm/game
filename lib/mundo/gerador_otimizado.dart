import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/config/constantes.dart';

class GeradorMundoOtimizado {
  static Chunk gerarChunk(int x, int z) {
    final chunk = Chunk(x, z);
    final blocos = chunk.blocos;

    for (var i = 0; i < Constantes.chunkTamanho; i++) {
      for (var j = 0; j < Constantes.chunkAltura; j++) {
        for (var k = 0; k < Constantes.chunkTamanho; k++) {
          final altura = _calcularAltura(x * Constantes.chunkTamanho + i, z * Constantes.chunkTamanho + k);
          if (j < altura) {
            blocos[i][j][k] = TipoBloco.pedra;
          } else if (j == altura) {
            blocos[i][j][k] = TipoBloco.grama;
          } else {
            blocos[i][j][k] = TipoBloco.ar;
          }
        }
      }
    }

    return chunk;
  }

  static int _calcularAltura(int x, int z) {
    // Lógica simplificada para calcular altura
    return (x + z) ~/ 2 + Constantes.terrenoAlturaBase;
  }
}
