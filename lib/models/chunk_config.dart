class ChunkConfig {
  static const int chunkSize = 16;
  static const int neighborChunks = 1;

  static int getChunkIndex(int x, int z) {
    return (x ~/ chunkSize) + (z ~/ chunkSize) * 1000; // Assuming a large enough world size
  }

  static bool isChunkLoaded(int chunkX, int chunkZ, int playerChunkX, int playerChunkZ) {
    return (chunkX - playerChunkX).abs() <= neighborChunks && (chunkZ - playerChunkZ).abs() <= neighborChunks;
  }
}
