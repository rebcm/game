import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/chunk_config.dart';

void main() {
  test('ChunkConfig has correct values', () {
    expect(ChunkConfig.chunkSize, 16);
    expect(ChunkConfig.chunksInMemory, 3);
    expect(ChunkConfig.chunkDiameter, ChunkConfig.chunkSize);
    expect(ChunkConfig.chunksInMemoryDiameter, ChunkConfig.chunksInMemory);
  });
}
