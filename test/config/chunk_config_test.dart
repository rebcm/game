import 'package:flutter_test/flutter_test.dart';
import 'package:game/config/chunk_config.dart';

void main() {
  test('Chunk size is 16', () {
    expect(ChunkConfig.getChunkSize(), 16);
  });

  test('Neighbor chunks is 1', () {
    expect(ChunkConfig.getNeighborChunks(), 1);
  });
}
