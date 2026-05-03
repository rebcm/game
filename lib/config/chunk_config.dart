class ChunkConfig {
  static const int chunkSize = 16;
  static const int neighborChunks = 1;

  static int getChunkSize() => chunkSize;
  static int getNeighborChunks() => neighborChunks;
}
