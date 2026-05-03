import 'package:game/config/chunk_config.dart';

class ChunkManager {
  int getChunkDimension() {
    return ChunkConfig.getChunkSize();
  }

  int getNeighborChunkCount() {
    return ChunkConfig.getNeighborChunks();
  }
}
