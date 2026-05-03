import 'package:flutter_test/flutter_test.dart';
import 'package:game/domain/contracts/chunk_contract.dart';
import 'package:game/domain/entities/chunk.dart';

void main() {
  group('ChunkEntity Tests', () {
    test('should create a ChunkEntity instance correctly', () {
      final chunk = Chunk(
        x: 0,
        z: 0,
        blocks: [],
        isLastChunk: false,
      );

      final chunkEntity = ChunkEntity(chunk);

      expect(chunkEntity.chunk, chunk);
    });
  });
}
