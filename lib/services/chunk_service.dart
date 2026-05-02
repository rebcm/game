import 'package:rebcm/models/chunk.dart';
import 'package:rebcm/utils/loop_optimizer.dart';

class ChunkService {
  List<Chunk> generateChunks(List<dynamic> data, int chunkSize) {
    List<Chunk> chunks = [];
    for (var i = 0; i < data.length; i += chunkSize) {
      chunks.add(Chunk(data: data.sublist(i, i + chunkSize)));
    }
    LoopOptimizer.optimizeChunkGeneration(chunks);
    return chunks;
  }
}
