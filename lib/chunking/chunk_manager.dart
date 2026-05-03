import 'package:flutter/foundation.dart';

class ChunkManager with ChangeNotifier {
  static const int chunkSize = 16;
  static const int cacheSize = 3; // 3x3 chunks ao redor do atual

  List<List<int>> _loadedChunks = [];

  void loadChunk(int x, int z) {
    // Lógica para carregar o chunk
    // ...
  }

  void unloadChunk(int x, int z) {
    // Lógica para descarregar o chunk
    // ...
  }

  void updateChunks(int playerX, int playerZ) {
    // Calcula quais chunks devem ser carregados ou descarregados com base na posição do jogador
    for (int x = playerX - cacheSize; x <= playerX + cacheSize; x++) {
      for (int z = playerZ - cacheSize; z <= playerZ + cacheSize; z++) {
        if (!_isChunkLoaded(x, z)) {
          loadChunk(x, z);
        }
      }
    }

    // Descarrega chunks que estão fora do cache
    _loadedChunks.removeWhere((chunk) {
      int dx = (chunk[0] - playerX).abs();
      int dz = (chunk[1] - playerZ).abs();
      return dx > cacheSize || dz > cacheSize;
    });

    notifyListeners();
  }

  bool _isChunkLoaded(int x, int z) {
    return _loadedChunks.any((chunk) => chunk[0] == x && chunk[1] == z);
  }
}

