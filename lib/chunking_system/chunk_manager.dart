import 'package:game/chunking_system/chunk.dart';

class ChunkManager {
  final int chunkSize;
  final int renderDistance;
  final Map<String, Chunk> chunks = {};

  ChunkManager({required this.chunkSize, required this.renderDistance});

  String _getChunkKey(int x, int z) => '$x,$z';

  Chunk? getChunk(int x, int z) => chunks[_getChunkKey(x, z)];

  void loadChunk(int x, int z) {
    final chunk = Chunk(x: x, z: z);
    chunk.isLoaded = true;
    chunks[_getChunkKey(x, z)] = chunk;
  }

  void unloadChunk(int x, int z) {
    chunks.remove(_getChunkKey(x, z));
  }

  void updateChunks(int playerX, int playerZ) {
    final playerChunkX = playerX ~/ chunkSize;
    final playerChunkZ = playerZ ~/ chunkSize;

    for (int x = -renderDistance; x <= renderDistance; x++) {
      for (int z = -renderDistance; z <= renderDistance; z++) {
        final chunkX = playerChunkX + x;
        final chunkZ = playerChunkZ + z;
        if (getChunk(chunkX, chunkZ) == null) {
          loadChunk(chunkX, chunkZ);
        }
      }
    }

    chunks.removeWhere((key, chunk) {
      final chunkCoords = key.split(',');
      final chunkX = int.parse(chunkCoords[0]);
      final chunkZ = int.parse(chunkCoords[1]);
      final distance = ((chunkX - playerChunkX).abs() + (chunkZ - playerChunkZ).abs());
      return distance > renderDistance;
    });
  }
}
