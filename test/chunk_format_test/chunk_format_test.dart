import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk_service.dart';

void main() {
  group('Chunk Format Test', () {
    test('Valid chunk format should be accepted', () async {
      final validChunkData = 'valid_chunk_data';
      final result = await ChunkService.validateChunkFormat(validChunkData);
      expect(result, isTrue);
    });

    test('Invalid chunk format should be rejected', () async {
      final invalidChunkData = 'invalid_chunk_data';
      final result = await ChunkService.validateChunkFormat(invalidChunkData);
      expect(result, isFalse);
    });

    test('Empty chunk data should be rejected', () async {
      final emptyChunkData = '';
      final result = await ChunkService.validateChunkFormat(emptyChunkData);
      expect(result, isFalse);
    });

    test('Null chunk data should be rejected', () async {
      final nullChunkData = null;
      final result = await ChunkService.validateChunkFormat(nullChunkData);
      expect(result, isFalse);
    });
  });
}
