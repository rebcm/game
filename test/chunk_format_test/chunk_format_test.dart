import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk_service.dart';

void main() {
  group('Chunk Format Test', () {
    test('Valid chunk format is accepted', () async {
      final validChunk = ChunkService.createChunk();
      expect(await ChunkService.isValidChunkFormat(validChunk), true);
    });

    test('Invalid chunk format is rejected', () async {
      final invalidChunk = 'Invalid chunk data';
      expect(await ChunkService.isValidChunkFormat(invalidChunk), false);
    });

    test('Empty chunk is rejected', () async {
      final emptyChunk = '';
      expect(await ChunkService.isValidChunkFormat(emptyChunk), false);
    });

    test('Chunk with wrong data type is rejected', () async {
      final wrongDataTypeChunk = 12345;
      expect(await ChunkService.isValidChunkFormat(wrongDataTypeChunk), false);
    });
  });
}
