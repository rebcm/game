import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk/chunk_manager.dart';

void main() {
  group('ChunkManager', () {
    test('loads and unloads chunks correctly', () {
      final chunkManager = ChunkManager();
      final chunk = Chunk();

      chunkManager.loadChunk(chunk);
      expect(chunkManager.chunks, contains(chunk));

      chunkManager.unloadChunk(chunk);
      expect(chunkManager.chunks, isNot(contains(chunk)));
    });

    test('updates chunk colliders', () {
      final chunkManager = ChunkManager();
      final chunk = Chunk();

      chunkManager.loadChunk(chunk);
      chunkManager.updateChunkColliders();

      expect(chunk.isLoaded, isTrue);
    });
  });
}
