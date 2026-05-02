import 'package:test/test.dart';
import 'package:rebcm/services/chunk_service.dart';

void main() {
  group('Chunk Format Validation', () {
    test('should accept valid chunk file format', () async {
      final validChunkFile = File('assets/test_data/valid_chunk.dat');
      final result = await ChunkService.validateChunkFile(validChunkFile);
      expect(result, isTrue);
    });

    test('should reject invalid chunk file format', () async {
      final invalidChunkFile = File('assets/test_data/invalid_chunk.dat');
      final result = await ChunkService.validateChunkFile(invalidChunkFile);
      expect(result, isFalse);
    });

    test('should reject chunk file with incorrect magic number', () async {
      final invalidMagicNumberChunkFile = File('assets/test_data/invalid_magic_number_chunk.dat');
      final result = await ChunkService.validateChunkFile(invalidMagicNumberChunkFile);
      expect(result, isFalse);
    });

    test('should reject chunk file with incorrect version', () async {
      final invalidVersionChunkFile = File('assets/test_data/invalid_version_chunk.dat');
      final result = await ChunkService.validateChunkFile(invalidVersionChunkFile);
      expect(result, isFalse);
    });
  });
}
