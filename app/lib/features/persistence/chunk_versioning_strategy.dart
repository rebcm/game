class ChunkVersioningStrategy {
  static String getChunkFileName(int chunkX, int chunkZ, int version) {
    return 'chunk_${chunkX}_${chunkZ}_v$version.dat';
  }

  static String getChunkDirectoryPath(String worldName) {
    return 'worlds/$worldName/chunks';
  }

  static String getChunkFilePath(String worldName, int chunkX, int chunkZ, int version) {
    return '${getChunkDirectoryPath(worldName)}/${getChunkFileName(chunkX, chunkZ, version)}';
  }

  static int getLatestChunkVersion(String worldName, int chunkX, int chunkZ) {
    // Implement logic to determine the latest version of a chunk
    // For now, return 0 as the default version
    return 0;
  }
}
