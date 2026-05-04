import 'package:game/cache/lru_cache.dart';
import 'package:game/models/chunk.dart';

class ChunkCache {
  late final LRUCache<String, Chunk> _cache;

  ChunkCache(int capacity) {
    _cache = LRUCache<String, Chunk>(capacity);
  }

  Chunk? getChunk(String id) {
    return _cache.get(id);
  }

  void cacheChunk(Chunk chunk) {
    _cache.put(chunk.id, chunk);
  }

  void removeChunk(String id) {
    _cache.remove(id);
  }

  void clear() {
    _cache.clear();
  }
}
