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

    test('should reject chunk file with incorrect dimensions', () async {
      // Arrange
      final incorrectDimensionsChunkFile = File('assets/test/incorrect_dimensions_chunk.bin');
      // Act
      final result = await ChunkService.validateChunkFile(incorrectDimensionsChunkFile);
      // Assert
      expect(result, isFalse);
    });

    test('should reject chunk file with corrupted data', () async {
      // Arrange
      final corruptedChunkFile = File('assets/test/corrupted_chunk.bin');
      // Act
      final result = await ChunkService.validateChunkFile(corruptedChunkFile);
      // Assert
      expect(result, isFalse);
    });
  });
}
