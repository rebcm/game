import 'package:game/cache/lru_cache.dart';

class ChunkManager {
  final LRUCache<String, Chunk> _chunkCache;
  final int _cacheCapacity;

  ChunkManager(this._cacheCapacity) : _chunkCache = LRUCache(_cacheCapacity);

  Chunk? getChunk(String chunkKey) {
    return _chunkCache.get(chunkKey);
  }

  void loadChunk(String chunkKey, Chunk chunk) {
    _chunkCache.put(chunkKey, chunk);
  }

  void unloadChunk(String chunkKey) {
    _chunkCache.remove(chunkKey);
  }

  void clearChunks() {
    _chunkCache.clear();
  }
}

class Chunk {
  // Chunk implementation details
}
