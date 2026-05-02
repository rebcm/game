import 'package:rebcm/mundo/chunks/chunk.dart';

class GerenciadorChunks {
  final Map<(int, int), Chunk> _chunksCarregados = {};
  final int _tamanhoChunk = 16;

  Chunk? obterChunk(int x, int z) {
    final chaveChunk = (x ~/ _tamanhoChunk, z ~/ _tamanhoChunk);
    return _chunksCarregados[chaveChunk];
  }

  void carregarChunk(int x, int z) {
    final chaveChunk = (x ~/ _tamanhoChunk, z ~/ _tamanhoChunk);
    if (!_chunksCarregados.containsKey(chaveChunk)) {
      _chunksCarregados[chaveChunk] = Chunk(x, z, _tamanhoChunk);
    }
  }

  void descarregarChunk(int x, int z) {
    final chaveChunk = (x ~/ _tamanhoChunk, z ~/ _tamanhoChunk);
    if (_chunksCarregados.containsKey(chaveChunk)) {
      _chunksCarregados.remove(chaveChunk);
    }
  }

  void atualizarChunksCarregados(int posicaoRebecaX, int posicaoRebecaZ, int raioCarregamento) {
    for (int x = posicaoRebecaX - raioCarregamento; x <= posicaoRebecaX + raioCarregamento; x += _tamanhoChunk) {
      for (int z = posicaoRebecaZ - raioCarregamento; z <= posicaoRebecaZ + raioCarregamento; z += _tamanhoChunk) {
        carregarChunk(x, z);
      }
    }
    
    final chunksParaDescarregar = _chunksCarregados.keys.where((chaveChunk) {
      final distanciaX = (chaveChunk.$1 * _tamanhoChunk + _tamanhoChunk / 2) - posicaoRebecaX;
      final distanciaZ = (chaveChunk.$2 * _tamanhoChunk + _tamanhoChunk / 2) - posicaoRebecaZ;
      return distanciaX * distanciaX + distanciaZ * distanciaZ > raioCarregamento * raioCarregamento;
    }).toList();

    for (var chaveChunk in chunksParaDescarregar) {
      descarregarChunk(chaveChunk.$1 * _tamanhoChunk, chaveChunk.$2 * _tamanhoChunk);
    }
  }
}
