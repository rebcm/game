import 'dart:math';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';

class Mundo {
  final int largura = Constantes.worldX;
  final int altura = Constantes.worldY;
  final int profundidade = Constantes.worldZ;
  late List<List<List<TipoBloco>>> _blocos;

  Mundo() {
    _blocos = List.generate(
      largura,
      (_) => List.generate(
        altura,
        (_) => List.generate(profundidade, (_) => TipoBloco.ar),
      ),
    );
    _gerar();
  }

  TipoBloco get(int x, int y, int z) {
    if (x < 0 || x >= largura || y < 0 || y >= altura || z < 0 || z >= profundidade) {
      return TipoBloco.ar;
    }
    return _blocos[x][y][z];
  }

  void set(int x, int y, int z, TipoBloco bloco) {
    if (x < 0 || x >= largura || y < 0 || y >= altura || z < 0 || z >= profundidade) return;
    _blocos[x][y][z] = bloco;
  }

  bool isSolido(int x, int y, int z) => get(x, y, z).solido;

  int alturaSuperficie(int x, int z) {
    for (int y = altura - 1; y >= 0; y--) {
      if (isSolido(x, y, z)) return y;
    }
    return 0;
  }

  void _gerar() {
    final rng = Random(42);
    for (int x = 0; x < largura; x++) {
      for (int z = 0; z < profundidade; z++) {
        final h = _alturaTerreno(x, z);
        for (int y = 0; y <= h; y++) {
          TipoBloco b;
          if (y == 0 || y < h - 3) {
            b = TipoBloco.pedra;
          } else if (y < h) {
            b = TipoBloco.terra;
          } else if (h <= 4) {
            b = TipoBloco.areia;
          } else if (h >= 10) {
            b = TipoBloco.neve;
          } else {
            b = TipoBloco.grama;
          }
          _blocos[x][y][z] = b;
        }
      }
    }

    for (int i = 0; i < 18; i++) {
      final tx = 4 + rng.nextInt(largura - 8);
      final tz = 4 + rng.nextInt(profundidade - 8);
      final th = _alturaTerreno(tx, tz);
      if (get(tx, th, tz) == TipoBloco.grama) {
        _plantarArvore(tx, th + 1, tz, rng);
      }
    }

    // Random ore deposits underground
    for (int i = 0; i < 30; i++) {
      final ox = rng.nextInt(largura);
      final oz = rng.nextInt(profundidade);
      final oy = 1 + rng.nextInt(4);
      if (get(ox, oy, oz) == TipoBloco.pedra) {
        set(ox, oy, oz, rng.nextBool() ? TipoBloco.diamante : TipoBloco.ouro);
      }
    }
  }

  // Smooth height using layered sine waves
  int _alturaTerreno(int x, int z) {
    final nx = x / largura.toDouble();
    final nz = z / profundidade.toDouble();
    double v = sin(nx * pi * 2.0) * cos(nz * pi * 2.0) * 0.45
             + sin(nx * pi * 5.0 + 1.3) * sin(nz * pi * 3.0 + 0.8) * 0.30
             + sin(nx * pi * 11.0 + 2.5) * cos(nz * pi * 7.0 + 1.9) * 0.15
             + sin(nx * pi * 17.0 + 4.1) * sin(nz * pi * 13.0 + 3.3) * 0.10;
    v = (v + 1.0) / 2.0;
    return 3 + (v * 9).toInt().clamp(0, 9);
  }

  void _plantarArvore(int x, int y, int z, Random rng) {
    final h = 4 + rng.nextInt(3);
    for (int i = 0; i < h; i++) {
      set(x, y + i, z, TipoBloco.madeira);
    }
    for (int dx = -2; dx <= 2; dx++) {
      for (int dz = -2; dz <= 2; dz++) {
        for (int dy = h - 2; dy <= h + 1; dy++) {
          if (dx == 0 && dz == 0 && dy < h) continue;
          if (dx * dx + dz * dz <= 5) {
            if (get(x + dx, y + dy, z + dz) == TipoBloco.ar) {
              set(x + dx, y + dy, z + dz, TipoBloco.folha);
            }
          }
        }
      }
    }
    set(x, y + h, z, TipoBloco.folha);
    set(x, y + h + 1, z, TipoBloco.folha);
  }
}
