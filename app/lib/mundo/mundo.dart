import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mundo/chunk.dart';

/// Fachada do mundo do jogo. Mantém a API antiga (get/set/isSolido/alturaSuperficie)
/// mas delega para [ChunkMundo], permitindo mundo virtualmente infinito.
class Mundo {
  final ChunkMundo chunks;

  // Compat: usado pelo renderer/personagem como referência de bounds para
  // operações que ainda assumem mundo fechado. Sempre que possível use
  // diretamente [chunks].
  final int largura = Constantes.worldX;
  final int altura = Constantes.worldY;
  final int profundidade = Constantes.worldZ;

  Mundo({int seed = 42}) : chunks = ChunkMundo(seed: seed);

  TipoBloco get(int x, int y, int z) => chunks.get(x, y, z);
  void set(int x, int y, int z, TipoBloco b) => chunks.set(x, y, z, b);
  bool isSolido(int x, int y, int z) => chunks.isSolido(x, y, z);
  int alturaSuperficie(int x, int z) => chunks.alturaSuperficie(x, z);

  /// Atualiza chunks ao redor das coordenadas globais [px], [pz] do jogador.
  void atualizarChunksProximos(double px, double pz) {
    final cs = Constantes.chunkSize;
    final cx = (px / cs).floor();
    final cz = (pz / cs).floor();
    chunks.garantirChunksAoRedor(cx, cz, Constantes.viewRadius + 1);
  }
}
