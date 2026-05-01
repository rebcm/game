import '../blocos/tipo_bloco.dart';
import '../config/constantes.dart';
import 'posicao3d.dart';

class Chunk {
  final int chunkX;
  final int chunkZ;
  final List<List<List<TipoBloco>>> blocos;
  bool modificado = false;

  Chunk({required this.chunkX, required this.chunkZ})
      : blocos = List.generate(
          Constantes.tamanhoChunk,
          (_) => List.generate(
            Constantes.alturaMaxima,
            (_) => List.filled(Constantes.tamanhoChunk, TipoBloco.ar),
          ),
        );

  TipoBloco pegarBloco(int x, int y, int z) {
    if (_foraDoLimite(x, y, z)) return TipoBloco.ar;
    return blocos[x][y][z];
  }

  void definirBloco(int x, int y, int z, TipoBloco tipo) {
    if (_foraDoLimite(x, y, z)) return;
    blocos[x][y][z] = tipo;
    modificado = true;
  }

  bool _foraDoLimite(int x, int y, int z) =>
      x < 0 || x >= Constantes.tamanhoChunk ||
      y < 0 || y >= Constantes.alturaMaxima ||
      z < 0 || z >= Constantes.tamanhoChunk;

  Posicao3D get posicaoMundo =>
      Posicao3D(chunkX * Constantes.tamanhoChunk, 0, chunkZ * Constantes.tamanhoChunk);

  Map<String, dynamic> paraJson() {
    final dados = <String, dynamic>{
      'chunkX': chunkX,
      'chunkZ': chunkZ,
      'blocos': <List<List<int>>>[],
    };
    for (var x = 0; x < Constantes.tamanhoChunk; x++) {
      final camadaX = <List<int>>[];
      for (var y = 0; y < Constantes.alturaMaxima; y++) {
        camadaX.add(
          List.generate(
            Constantes.tamanhoChunk,
            (z) => blocos[x][y][z].index,
          ),
        );
      }
      (dados['blocos'] as List).add(camadaX);
    }
    return dados;
  }
}
