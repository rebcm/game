import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk_manager/chunk_collision_manager.dart';

void main() {
  group('ChunkCollisionManager', () {
    test('should update loaded chunks', () {
      var manager = ChunkCollisionManager();
      var chunks = [Chunk(), Chunk()];
      manager.updateLoadedChunks(chunks);
      expect(manager._loadedChunks, chunks);
    });

    test('should validate adjacent chunk colliders', () {
      var manager = ChunkCollisionManager();
      var chunk1 = Chunk();
      var chunk2 = Chunk();
      manager.updateLoadedChunks([chunk1, chunk2]);
      manager.validateAdjacentChunkColliders();
      // Verify that colliders are synced
    });
  });
}
