class ChunkConfig {
  static const int chunkSize = 16;
  static const int bufferZone = 2;

  static int get chunkLoadDistance => chunkSize * bufferZone;
}
