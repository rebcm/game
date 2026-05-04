import 'package:flutter_test/flutter_test.dart';
import 'package:game/cache/chunk_cache.dart';
import 'package:game/models/chunk.dart';

void main() {
  group('ChunkCache', () {
    test('should cache and retrieve a chunk', () {
      final cache = ChunkCache(10);
      final chunk = Chunk(id: '1', data: 'data');

      cache.cacheChunk(chunk);

      expect(cache.getChunk('1'), chunk);
    });

    test('should remove a chunk from the cache', () {
      final cache = ChunkCache(10);
      final chunk = Chunk(id: '1', data: 'data');

      cache.cacheChunk(chunk);
      cache.removeChunk('1');

      expect(cache.getChunk('1'), null);
    });

    test('should clear the cache', () {
      final cache = ChunkCache(10);
      final chunk1 = Chunk(id: '1', data: 'data1');
      final chunk2 = Chunk(id: '2', data: 'data2');

      cache.cacheChunk(chunk1);
      cache.cacheChunk(chunk2);
      cache.clear();

      expect(cache.getChunk('1'), null);
      expect(cache.getChunk('2'), null);
    });
  });
}
