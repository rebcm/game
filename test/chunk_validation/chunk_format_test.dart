import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk_service.dart';

void main() {
  group('Chunk Format Validation', () {
    test('should accept valid chunk file format', () async {
      // Arrange
      final validChunkFile = File('assets/test/valid_chunk.bin');
      // Act
      final result = await ChunkService.validateChunkFile(validChunkFile);
      // Assert
      expect(result, isTrue);
    });

    test('should reject invalid chunk file format', () async {
      // Arrange
      final invalidChunkFile = File('assets/test/invalid_chunk.txt');
      // Act
      final result = await ChunkService.validateChunkFile(invalidChunkFile);
      // Assert
      expect(result, isFalse);
    });

    test('should reject chunk file with incorrect magic number', () async {
      // Arrange
      final invalidMagicNumberChunkFile = File('assets/test/invalid_magic_number_chunk.bin');
      // Act
      final result = await ChunkService.validateChunkFile(invalidMagicNumberChunkFile);
      // Assert
      expect(result, isFalse);
    });

    test('should reject chunk file with incorrect version', () async {
      // Arrange
      final invalidVersionChunkFile = File('assets/test/invalid_version_chunk.bin');
      // Act
      final result = await ChunkService.validateChunkFile(invalidVersionChunkFile);
      // Assert
      expect(result, isFalse);
    });
  });
}
