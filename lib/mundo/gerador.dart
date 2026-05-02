import Intl.message('dart:math');
import Intl.message('../blocos/tipo_bloco.dart');
import Intl.message('../config/constantes.dart');
import Intl.message('chunk.dart');

class GeradorMundo {
  final int semente;
  final Random _random;

  GeradorMundo({int? semente})
      : semente = semente ?? DateTime.now().millisecondsSinceEpoch,
        _random = Random(semente ?? DateTime.now().millisecondsSinceEpoch);

  Chunk gerarChunk(int chunkX, int chunkZ) {
    final chunk = Chunk(chunkX: chunkX, chunkZ: chunkZ);
    final alturaBase = 12;

    for (var x = 0; x < Constantes.tamanhoChunk; x++) {
      for (var z = 0; z < Constantes.tamanhoChunk; z++) {
        final mundoX = chunkX * Constantes.tamanhoChunk + x;
        final mundoZ = chunkZ * Constantes.tamanhoChunk + z;
        final altura = _calcularAltura(mundoX, mundoZ, alturaBase);

        // Bedrock na base
        chunk.definirBloco(x, 0, z, TipoBloco.pedra);

        // Pedra da base até altura - 4
        for (var y = 1; y < altura - 3; y++) {
          chunk.definirBloco(x, y, z, TipoBloco.pedra);
        }

        // Terra até a superfície
        for (var y = max(1, altura - 3); y < altura - 1; y++) {
          chunk.definirBloco(x, y, z, TipoBloco.terra);
        }

        // Superfície: grama
        chunk.definirBloco(x, altura - 1, z, TipoBloco.grama);

        // Árvores ocasionais
        if (_random.nextDouble() < 0.02) {
          _plantarArvore(chunk, x, altura, z);
        }
      }
    }

    return chunk;
  }

  int _calcularAltura(int x, int z, int base) {
    final ruido = sin(x * 0.1) * cos(z * 0.1) * 4;
    return (base + ruido).round().clamp(6, Constantes.alturaMaxima - 10);
  }

  void _plantarArvore(Chunk chunk, int x, int alturaSolo, int z) {
    final alturaArvore = 4 + _random.nextInt(3);
    if (x < 2 || x > Constantes.tamanhoChunk - 3 ||
        z < 2 || z > Constantes.tamanhoChunk - 3) {
      return;
    }

    // Tronco
    for (var y = alturaSolo; y < alturaSolo + alturaArvore; y++) {
      chunk.definirBloco(x, y, z, TipoBloco.tronco);
    }

    // Copa de folhas
    final topoArvore = alturaSolo + alturaArvore;
    for (var dy = -1; dy <= 1; dy++) {
      for (var dx = -2; dx <= 2; dx++) {
        for (var dz = -2; dz <= 2; dz++) {
          if (dx == 0 && dz == 0 && dy <= 0) continue;
          final fx = x + dx;
          final fy = topoArvore + dy;
          final fz = z + dz;
          if (fx < 0 || fx >= Constantes.tamanhoChunk ||
              fz < 0 || fz >= Constantes.tamanhoChunk) {
            continue;
          }
          if (fy >= Constantes.alturaMaxima) { continue; }
          chunk.definirBloco(fx, fy, fz, TipoBloco.folhas);
        }
      }
    }
  }
}
