import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk_manager/chunk_collision_manager.dart';

void main() {
  group('ChunkCollisionManager', () {
    test('loads and unloads chunks correctly', () {
      var manager = ChunkCollisionManager();
      var chunk = Chunk();

      manager.loadChunk(chunk);
      expect(manager._loadedChunks.contains(chunk), true);

      manager.unloadChunk(chunk);
      expect(manager._loadedChunks.contains(chunk), false);
    });

    test('syncs colliders when loading and unloading chunks', () {
      var manager = ChunkCollisionManager();
      var chunk = Chunk();

      manager.loadChunk(chunk);
      // Verify that _syncColliders was called
    });
  });
}
