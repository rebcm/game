import 'package:game/models/chunk_config.dart';

class ChunkManager {
  void loadChunks(int playerX, int playerZ) {
    int chunkX = playerX ~/ ChunkConfig.chunkSize;
    int chunkZ = playerZ ~/ ChunkConfig.chunkSize;

    for (int x = -ChunkConfig.chunksInMemoryDiameter ~/ 2; x <= ChunkConfig.chunksInMemoryDiameter ~/ 2; x++) {
      for (int z = -ChunkConfig.chunksInMemoryDiameter ~/ 2; z <= ChunkConfig.chunksInMemoryDiameter ~/ 2; z++) {
        int targetChunkX = chunkX + x;
        int targetChunkZ = chunkZ + z;
        // Implement logic to load chunk at (targetChunkX, targetChunkZ)
        print('Loading chunk ($targetChunkX, $targetChunkZ)');
      }
    }
  }
}
