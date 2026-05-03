import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_manager/chunk.dart';
import 'package:game/services/chunk_manager/chunk_manager.dart';

void main() {
  group('ChunkManager', () {
    test('chunksToPreload updates when playerChunk changes', () {
      ChunkManager chunkManager = ChunkManager();
      Chunk playerChunk = Chunk(x: 0, z: 0);
      List<Chunk> allChunks = [
        Chunk(x: 0, z: 0),
        Chunk(x: 1, z: 0),
      ];

      chunkManager.updateAllChunks(allChunks);
      chunkManager.updatePlayerChunk(playerChunk);

      expect(chunkManager.chunksToPreload, contains(Chunk(x: 0, z: 0)));
      expect(chunkManager.chunksToPreload, contains(Chunk(x: 1, z: 0)));

      Chunk newPlayerChunk = Chunk(x: 1, z: 1);
      chunkManager.updatePlayerChunk(newPlayerChunk);

      expect(chunkManager.chunksToPreload, isNot(contains(Chunk(x: 0, z: 0))));
    });
  });
}
