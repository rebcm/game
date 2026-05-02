import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunking_service.dart';

void main() {
  group('Chunking Stress Test', () {
    test('should handle chunk files above the allowed limit', () async {
      final chunkingService = ChunkingService();
      final largeChunk = List.generate(1000000, (index) => index.toString());
      await expectLater(
        () => chunkingService.processChunk(largeChunk),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle multiple large chunk files', () async {
      final chunkingService = ChunkingService();
      final largeChunks = List.generate(
        10,
        (index) => List.generate(1000000, (i) => '$index$i'),
      );
      for (var chunk in largeChunks) {
        await expectLater(
          () => chunkingService.processChunk(chunk),
          throwsA(isA<Exception>()),
        );
      }
    });
  });
}
