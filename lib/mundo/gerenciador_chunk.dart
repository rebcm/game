import 'package:rebcm/mundo/versionador_chunk.dart';

class GerenciadorChunk {
  Future<void> inicializar() async {
    await VersionadorChunk.atualizarVersao();
  }

  String obterCaminhoChunk(int x, int z, int versao) {
    return 'chunks/v$versao/chunk_$x\_$z.dat';
  }
}
