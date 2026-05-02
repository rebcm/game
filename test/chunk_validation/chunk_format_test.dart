import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk_service.dart';

void main() {
  group('Chunk Format Validation', () {
    test('should accept valid chunk file', () async {
      final validChunk = await ChunkService.validateChunkFormat('valid_chunk.bin');
      expect(validChunk, true);
    });

    test('should reject invalid chunk file', () async {
      final invalidChunk = await ChunkService.validateChunkFormat('invalid_chunk.bin');
      expect(invalidChunk, false);
    });

    test('should reject chunk file with incorrect extension', () async {
      final incorrectExtension = await ChunkService.validateChunkFormat('valid_chunk.txt');
      expect(incorrectExtension, false);
    });

    test('should reject chunk file with corrupted data', () async {
      final corruptedData = await ChunkService.validateChunkFormat('corrupted_chunk.bin');
      expect(corruptedData, false);
    });
  });
}
