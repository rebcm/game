import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk_service.dart';

void main() {
  group('Chunk Format Test', () {
    test('should accept valid chunk file format', () async {
      // Arrange
      final validChunkFile = File('assets/test/valid_chunk.bin');
      final chunkService = ChunkService();

      // Act
      final result = await chunkService.validateChunkFile(validChunkFile);

      // Assert
      expect(result, isTrue);
    });

    test('should reject invalid chunk file format', () async {
      // Arrange
      final invalidChunkFile = File('assets/test/invalid_chunk.txt');
      final chunkService = ChunkService();

      // Act
      final result = await chunkService.validateChunkFile(invalidChunkFile);

      // Assert
      expect(result, isFalse);
    });

    test('should reject chunk file with incorrect magic number', () async {
      // Arrange
      final invalidMagicNumberChunkFile = File('assets/test/invalid_magic_number_chunk.bin');
      final chunkService = ChunkService();

      // Act
      final result = await chunkService.validateChunkFile(invalidMagicNumberChunkFile);

      // Assert
      expect(result, isFalse);
    });

    test('should reject chunk file with incorrect version', () async {
      // Arrange
      final invalidVersionChunkFile = File('assets/test/invalid_version_chunk.bin');
      final chunkService = ChunkService();

      // Act
      final result = await chunkService.validateChunkFile(invalidVersionChunkFile);

      // Assert
      expect(result, isFalse);
    });
  });
}
