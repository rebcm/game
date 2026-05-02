import 'dart:math';
import 'package:rebcm/blocos/tipo_bloco.dart';

class GeradorMundo {
  static Chunk gerarChunk(int x, int z, {int tamanho = 32, double complexidade = 0.5}) {
    final blocos = <Bloco>[];
    final rand = Random((x + z) * 12345);

    for (int i = 0; i < tamanho; i++) {
      for (int j = 0; j < tamanho; j++) {
        for (int k = 0; k < tamanho; k++) {
          final tipo = _escolherTipoBloco(i, j, k, rand, complexidade);
          blocos.add(Bloco(tipo, i, j, k));
        }
      }
    }

    return Chunk(blocos);
  }

  static TipoBloco _escolherTipoBloco(int x, int y, int z, Random rand, double complexidade) {
    if (y < 10) return TipoBloco.pedra;
    if (y < 15 && rand.nextDouble() < complexidade) return TipoBloco.terra;
    return TipoBloco.grama;
  }
}

class Chunk {
  final List<Bloco> blocos;

  Chunk(this.blocos);
}

class Bloco {
  final TipoBloco tipo;
  final int x, y, z;

  Bloco(this.tipo, this.x, this.y, this.z);
}
