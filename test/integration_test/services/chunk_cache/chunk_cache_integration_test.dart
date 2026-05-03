import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_cache/chunk_cache_service.dart';
import 'package:game/services/chunk_cache/chunk_cache_provider.dart';

void main() {
  group('ChunkCacheProvider', () {
    late ChunkCacheProvider chunkCacheProvider;

    setUp(() {
      chunkCacheProvider = ChunkCacheProvider();
    });

    testWidgets('provides chunk cache service', (tester) async {
      expect(chunkCacheProvider.chunkCacheService, isNotNull);
    });

    testWidgets('updates chunk cache service', (tester) async {
      final newChunkCacheService = ChunkCacheService(maxChunks: 10);
      chunkCacheProvider.updateChunkCacheService(newChunkCacheService);
      expect(chunkCacheProvider.chunkCacheService, newChunkCacheService);
    });
  });
}
