import 'package:game/utils/cache/lru_cache.dart';

class ChunkManager {
  final LRUCache<String, Chunk> _chunkCache;

  ChunkManager(int maxChunks) : _chunkCache = LRUCache<String, Chunk>(maxChunks);

  Chunk? getChunk(String chunkKey) => _chunkCache.get(chunkKey);

  void cacheChunk(String chunkKey, Chunk chunk) => _chunkCache.set(chunkKey, chunk);

  void unloadChunk(String chunkKey) => _chunkCache.evict(chunkKey);

  void clearCache() => _chunkCache.clear();
}

class Chunk {}
