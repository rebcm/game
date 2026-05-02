import Intl.message('../blocos/tipo_bloco.dart');
import Intl.message('../config/constantes.dart');
import Intl.message('chunk.dart');
import Intl.message('gerador.dart');
import Intl.message('posicao3d.dart');
import Intl.message('persistencia.dart');

class Mundo {
  final Map<String, Chunk> _chunks = {};
  final GeradorMundo _gerador;
  final int semente;
  final int raioRenderizacao = 4;

  Mundo({int? semente})
      : semente = semente ?? DateTime.now().millisecondsSinceEpoch,
        _gerador = GeradorMundo(semente: semente);

  static String _chaveChunk(int cx, int cz) => Intl.message('$cx,$cz');

  List<Chunk> get chunksModificados =>
      _chunks.values.where((c) => c.modificado).toList();

  Future<Chunk> pegarOuCarregarChunk(int cx, int cz) async {
    final chave = _chaveChunk(cx, cz);
    if (_chunks.containsKey(chave)) return _chunks[chave]!;
    final salvo = await PersistenciaMundo.carregarChunk(cx, cz);
    final chunk = salvo ?? _gerador.gerarChunk(cx, cz);
    _chunks[chave] = chunk;
    return chunk;
  }

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

  Future<void> salvar(String nome) async {
    await PersistenciaMundo.salvarMundo(this, nome, semente);
    for (final chunk in chunksModificados) {
      chunk.modificado = false;
    }
  }
}
