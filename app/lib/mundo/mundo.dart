import 'dart:math';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';

class Mundo {
  final int largura = Constantes.worldX;
  final int altura = Constantes.worldY;
  final int profundidade = Constantes.worldZ;
  late List<List<List<TipoBloco>>> _blocos;

  Mundo() {
    _blocos = List.generate(largura, (_) => List.generate(altura, (_) => List.generate(profundidade, (_) => TipoBloco.ar)));
    _gerar();
  }

  TipoBloco get(int x, int y, int z) {
    if (x < 0 || x >= largura || y < 0 || y >= altura || z < 0 || z >= profundidade) return TipoBloco.ar;
    return _blocos[x][y][z];
  }

  void set(int x, int y, int z, TipoBloco bloco) {
    if (x < 0 || x >= largura || y < 0 || y >= altura || z < 0 || z >= profundidade) return;
    _blocos[x][y][z] = bloco;
  }

  bool isSolido(int x, int y, int z) => get(x, y, z).solido;

  void _gerar() {
    final rng = Random(42);
    for (int x = 0; x < largura; x++) {
      for (int z = 0; z < profundidade; z++) {
        _blocos[x][0][z] = TipoBloco.pedra;
        _blocos[x][1][z] = TipoBloco.pedra;
        _blocos[x][2][z] = TipoBloco.terra;
        _blocos[x][3][z] = TipoBloco.terra;
        _blocos[x][4][z] = TipoBloco.grama;
        if (x < 3 || x > largura - 4 || z < 3 || z > profundidade - 4) {
          _blocos[x][4][z] = TipoBloco.areia;
          _blocos[x][3][z] = TipoBloco.areia;
        }
      }
    }
    for (int i = 0; i < 12; i++) {
      _plantarArvore(4 + rng.nextInt(largura - 8), 5, 4 + rng.nextInt(profundidade - 8));
    }
  }

  void _plantarArvore(int x, int y, int z) {
    for (int h = 0; h < 4; h++) set(x, y + h, z, TipoBloco.madeira);
    for (int dx = -2; dx <= 2; dx++) {
      for (int dz = -2; dz <= 2; dz++) {
        for (int dy = 3; dy <= 5; dy++) {
          if (dx == 0 && dz == 0 && dy < 4) continue;
          if ((dx * dx + dz * dz) <= (3 - dy + 3)) set(x + dx, y + dy, z + dz, TipoBloco.folha);
        }
      }
    }
  }
}
