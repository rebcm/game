import 'package:rebcm/mundo/chunks/gerenciador_chunks.dart';

class GeradorMundo {
  final GerenciadorChunks _gerenciadorChunks;

  GeradorMundo(this._gerenciadorChunks);

  void gerarMundo(int posicaoRebecaX, int posicaoRebecaZ) {
    _gerenciadorChunks.atualizarChunksCarregados(posicaoRebecaX, posicaoRebecaZ, 2);
  }
}
