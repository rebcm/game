import 'package:test/test.dart';
import 'dart:io';
import 'package:rebcm/services/chunk_service.dart';

void main() {
  group('Chunk File Format Validation', () {
    late ChunkService chunkService;

    setUp(() {
      chunkService = ChunkService();
    });

    test('should accept valid chunk file format', () async {
      final validChunkFile = File('test/chunk_validation/valid_chunk.bin');
      expect(await chunkService.validateChunkFile(validChunkFile), isTrue);
    });

    test('should reject invalid chunk file format', () async {
      final invalidChunkFile = File('test/chunk_validation/invalid_chunk.bin');
      expect(await chunkService.validateChunkFile(invalidChunkFile), isFalse);
    });

    test('should reject chunk file with incorrect extension', () async {
      final invalidChunkFile = File('test/chunk_validation/valid_chunk.txt');
      expect(await chunkService.validateChunkFile(invalidChunkFile), isFalse);
    });

    test('should reject empty chunk file', () async {
      final emptyChunkFile = File('test/chunk_validation/empty_chunk.bin');
      expect(await chunkService.validateChunkFile(emptyChunkFile), isFalse);
    });

    test('should reject chunk file with corrupted data', () async {
      final corruptedChunkFile = File('test/chunk_validation/corrupted_chunk.bin');
      expect(await chunkService.validateChunkFile(corruptedChunkFile), isFalse);
    });
  });
}
