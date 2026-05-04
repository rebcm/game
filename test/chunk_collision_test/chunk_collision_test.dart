import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk_manager.dart';
import 'package:game/collider.dart';

void main() {
  group('Chunk Collision Test', () {
    test('Adjacent chunks colliders are loaded and active', () {
      final chunkManager = ChunkManager();
      chunkManager.loadChunk(0, 0);
      chunkManager.loadChunk(1, 0);
      expect(chunkManager.getChunk(0, 0).colliders, isNotEmpty);
      expect(chunkManager.getChunk(1, 0).colliders, isNotEmpty);
      expect(chunkManager.getChunk(0, 0).colliders.first.isActive, isTrue);
      expect(chunkManager.getChunk(1, 0).colliders.first.isActive, isTrue);
    });

    test('Colliders are synchronized between adjacent chunks', () {
      final chunkManager = ChunkManager();
      chunkManager.loadChunk(0, 0);
      chunkManager.loadChunk(1, 0);
      final collidersChunk0 = chunkManager.getChunk(0, 0).colliders;
      final collidersChunk1 = chunkManager.getChunk(1, 0).colliders;
      expect(collidersChunk0.last.position.x, collidersChunk1.first.position.x - 1);
    });
  });
}
