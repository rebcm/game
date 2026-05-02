import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunking_service.dart';

void main() {
  group('Chunking Stress Test', () {
    test('should handle chunks above the allowed limit', () async {
      final chunkingService = ChunkingService();
      final largeChunk = List.generate(1000000, (index) => index);
      expect(() => chunkingService.processChunk(largeChunk), throwsException);
    });

    test('should handle multiple large chunks', () async {
      final chunkingService = ChunkingService();
      final largeChunks = List.generate(10, (_) => List.generate(1000000, (index) => index));
      for (var chunk in largeChunks) {
        expect(() => chunkingService.processChunk(chunk), throwsException);
      }
    });
  });
}
