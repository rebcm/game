import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_cache/chunk_cache_service.dart';

void main() {
  group('ChunkCacheService', () {
    late ChunkCacheService chunkCacheService;

    setUp(() {
      chunkCacheService = ChunkCacheService(maxChunks: 5);
    });

    test('adds chunk to cache', () {
      chunkCacheService.addChunk('chunk1', 'data1');
      expect(chunkCacheService.getChunk('chunk1'), 'data1');
    });

    test('removes chunk from cache', () {
      chunkCacheService.addChunk('chunk1', 'data1');
      chunkCacheService.removeChunk('chunk1');
      expect(chunkCacheService.getChunk('chunk1'), null);
    });

    test('unloads distant chunks when max chunks reached', () {
      for (int i = 0; i < 5; i++) {
        chunkCacheService.addChunk('chunk$i', 'data$i');
      }
      chunkCacheService.addChunk('chunk5', 'data5');
      expect(chunkCacheService.getChunk('chunk0'), null);
    });
  });
}
