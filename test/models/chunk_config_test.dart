import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/chunk_config.dart';

void main() {
  group('ChunkConfig', () {
    test('getChunkIndex', () {
      expect(ChunkConfig.getChunkIndex(0, 0), 0);
      expect(ChunkConfig.getChunkIndex(15, 0), 0);
      expect(ChunkConfig.getChunkIndex(16, 0), 1);
    });

    test('isChunkLoaded', () {
      expect(ChunkConfig.isChunkLoaded(0, 0, 0, 0), true);
      expect(ChunkConfig.isChunkLoaded(1, 1, 0, 0), true);
      expect(ChunkConfig.isChunkLoaded(2, 0, 0, 0), true);
      expect(ChunkConfig.isChunkLoaded(ChunkConfig.neighborChunks + 1, 0, 0, 0), false);
    });
  });
}
