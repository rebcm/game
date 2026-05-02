import 'package:rebcm/models/chunk.dart';

class ChunkService {
  List<Chunk> chunks;

  ChunkService(this.chunks);

  void optimizeChunks() {
    for (var chunk in chunks) {
      chunk.optimizeMemoryAllocation();
    }
  }

  void iterateChunks(void Function(Chunk) callback) {
    for (var chunk in chunks) {
      callback(chunk);
    }
  }
}
