import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk_manager.dart';
import 'package:game/chunk.dart';

void main() {
  group('Chunk Persistence Test', () {
    late ChunkManager chunkManager;

    setUp(() {
      chunkManager = ChunkManager();
    });

    test('should preserve chunk state after unloading and reloading', () async {
      // Arrange
      final chunk = Chunk(0, 0, 0);
      chunk.setBlock(0, 0, 0, 1);
      chunkManager.loadChunk(chunk);
      await chunkManager.saveChunk(chunk);

      // Act
      chunkManager.unloadChunk(chunk);
      final reloadedChunk = await chunkManager.loadChunk(chunk);

      // Assert
      expect(reloadedChunk.getBlock(0, 0, 0), 1);
    });
  });
}
