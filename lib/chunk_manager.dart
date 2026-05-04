import 'package:game/chunk.dart';
import 'package:game/collider.dart';

class ChunkManager {
  final Map<String, Chunk> _chunks = {};

  void loadChunk(int x, int z) {
    final chunk = Chunk(x, z);
    chunk.loadColliders();
    _chunks['$x,$z'] = chunk;
  }

  Chunk getChunk(int x, int z) => _chunks['$x,$z'];

  void updateColliders() {
    _chunks.forEach((key, chunk) {
      chunk.updateColliders();
    });
  }
}
