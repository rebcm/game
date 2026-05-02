import 'package:flutter_gl/flutter_gl.dart';
import 'package:rebcm/models/chunk.dart';

class ChunkManager {
  List<Chunk> _chunks = [];
  int _renderDistance = 3;

  void updateChunks(int playerX, int playerZ) {
    _chunks.clear();
    for (int x = -_renderDistance; x <= _renderDistance; x++) {
      for (int z = -_renderDistance; z <= _renderDistance; z++) {
        int chunkX = playerX + x;
        int chunkZ = playerZ + z;
        _chunks.add(Chunk(chunkX, chunkZ));
      }
    }
  }

  List<Chunk> getChunks() => _chunks;
}
