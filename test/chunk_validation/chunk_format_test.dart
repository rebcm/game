import 'package:test/test.dart';
import 'package:rebcm/chunk.dart';

void main() {
  group('Chunk Format Validation', () {
    test('should accept valid chunk file', () async {
      final validChunk = ChunkFile(/* valid chunk data */);
      expect(await validChunk.isValid(), true);
    });

    test('should reject chunk file with invalid format', () async {
      final invalidChunk = ChunkFile(/* invalid chunk data */);
      expect(await invalidChunk.isValid(), false);
    });

    test('should reject chunk file with corrupted data', () async {
      final corruptedChunk = ChunkFile(/* corrupted chunk data */);
      expect(await corruptedChunk.isValid(), false);
    });

    test('should reject chunk file with incorrect size', () async {
      final incorrectSizeChunk = ChunkFile(/* chunk data with incorrect size */);
      expect(await incorrectSizeChunk.isValid(), false);
    });
  });
}
