import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_manager/buffer_zone.dart';
import 'package:game/services/chunk_manager/chunk.dart';

void main() {
  group('BufferZone', () {
    test('getChunksToPreload returns chunks within radius', () {
      BufferZone bufferZone = BufferZone(radius: 1);
      Chunk playerChunk = Chunk(x: 0, z: 0);
      List<Chunk> allChunks = [
        Chunk(x: 0, z: 0),
        Chunk(x: 1, z: 0),
        Chunk(x: 0, z: 1),
        Chunk(x: 2, z: 0),
      ];

      List<Chunk> chunksToPreload = bufferZone.getChunksToPreload(allChunks, playerChunk);

      expect(chunksToPreload, contains(Chunk(x: 0, z: 0)));
      expect(chunksToPreload, contains(Chunk(x: 1, z: 0)));
      expect(chunksToPreload, contains(Chunk(x: 0, z: 1)));
      expect(chunksToPreload, isNot(contains(Chunk(x: 2, z: 0))));
    });
  });
}
