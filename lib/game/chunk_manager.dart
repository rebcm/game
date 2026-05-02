import 'dart:collection';
import 'package:rebcm/game/chunk.dart';

class ChunkManager {
  final Queue<Chunk> _chunksToUnload = Queue();

  void unloadChunk(Chunk chunk) {
    _chunksToUnload.add(chunk);
    // Unload chunks when they are no longer needed
    if (_chunksToUnload.length > 10) {
      Chunk chunkToUnload = _chunksToUnload.removeFirst();
      chunkToUnload.dispose();
    }
  }
}
