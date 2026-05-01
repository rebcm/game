import '../blocos/tipo_bloco.dart';
import '../config/constantes.dart';
import 'chunk.dart';
import 'gerador.dart';
import 'posicao3d.dart';

class Mundo {
  final Map<String, Chunk> _chunks = {};
  final GeradorMundo _gerador;
  final int raioRenderizacao = 4;

  Mundo({int? semente}) : _gerador = GeradorMundo(semente: semente);

  static String _chaveChunk(int cx, int cz) => '$cx,$cz';

  Chunk pegarOuGerarChunk(int cx, int cz) {
    final chave = _chaveChunk(cx, cz);
    return _chunks.putIfAbsent(chave, () => _gerador.gerarChunk(cx, cz));
  }

  TipoBloco pegarBloco(Posicao3D pos) {
    final cx = (pos.x / Constantes.tamanhoChunk).floor();
    final cz = (pos.z / Constantes.tamanhoChunk).floor();
    final lx = pos.x - cx * Constantes.tamanhoChunk;
    final lz = pos.z - cz * Constantes.tamanhoChunk;
    return pegarOuGerarChunk(cx, cz).pegarBloco(lx, pos.y, lz);
  }

  void definirBloco(Posicao3D pos, TipoBloco tipo) {
    final cx = (pos.x / Constantes.tamanhoChunk).floor();
    final cz = (pos.z / Constantes.tamanhoChunk).floor();
    final lx = pos.x - cx * Constantes.tamanhoChunk;
    final lz = pos.z - cz * Constantes.tamanhoChunk;
    pegarOuGerarChunk(cx, cz).definirBloco(lx, pos.y, lz, tipo);
  }

  int alturaSuperficie(int x, int z) {
    final cx = (x / Constantes.tamanhoChunk).floor();
    final cz = (z / Constantes.tamanhoChunk).floor();
    final lx = x - cx * Constantes.tamanhoChunk;
    final lz = z - cz * Constantes.tamanhoChunk;
    final chunk = pegarOuGerarChunk(cx, cz);

    for (var y = Constantes.alturaMaxima - 1; y >= 0; y--) {
      if (chunk.pegarBloco(lx, y, lz).solido) return y + 1;
    }
    return 0;
  }

  List<Chunk> chunksVisiveis(int cx, int cz) {
    final visivel = <Chunk>[];
    for (var dx = -raioRenderizacao; dx <= raioRenderizacao; dx++) {
      for (var dz = -raioRenderizacao; dz <= raioRenderizacao; dz++) {
        visivel.add(pegarOuGerarChunk(cx + dx, cz + dz));
      }
    }
    return visivel;
  }
}
