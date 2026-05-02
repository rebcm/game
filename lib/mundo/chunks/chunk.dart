import 'package:rebcm/blocos/tipo_bloco.dart';

class Chunk {
  final int _x;
  final int _z;
  final int _tamanho;
  late List<List<List<TipoBloco>>> _blocos;

  Chunk(this._x, this._z, this._tamanho) {
    _blocos = List.generate(
      _tamanho,
      (x) => List.generate(
        256,
        (y) => List.generate(
          _tamanho,
          (z) => TipoBloco.ar,
          growable: false,
        ),
        growable: false,
      ),
      growable: false,
    );
    _gerarBlocos();
  }

  void _gerarBlocos() {
    for (int x = 0; x < _tamanho; x++) {
      for (int z = 0; z < _tamanho; z++) {
        for (int y = 0; y < 256; y++) {
          _blocos[x][y][z] = TipoBloco.ar;
        }
      }
    }
  }

  TipoBloco obterBloco(int x, int y, int z) {
    final xLocal = x - _x;
    final zLocal = z - _z;
    if (xLocal < 0 || xLocal >= _tamanho || zLocal < 0 || zLocal >= _tamanho || y < 0 || y >= 256) {
      return TipoBloco.ar;
    }
    return _blocos[xLocal][y][zLocal];
  }

  void definirBloco(int x, int y, int z, TipoBloco tipo) {
    final xLocal = x - _x;
    final zLocal = z - _z;
    if (xLocal >= 0 && xLocal < _tamanho && zLocal >= 0 && zLocal < _tamanho && y >= 0 && y < 256) {
      _blocos[xLocal][y][zLocal] = tipo;
    }
  }
}
