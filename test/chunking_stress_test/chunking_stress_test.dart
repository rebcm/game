import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunking/chunk.dart';
import 'package:game/chunking/chunk_manager.dart';

void main() {
  group('Chunking Stress Test', () {
    test('Zero-sized chunk test', () async {
      final chunk = Chunk.empty();
      expect(() => ChunkManager.processChunk(chunk), throwsA(isA<ArgumentError>()));
    });

    test('Exceeding maximum allowed chunk size test', () async {
      final largeChunk = Chunk(
        data: List<int>.filled(ChunkManager.MAX_CHUNK_SIZE + 1, 0),
      );
      expect(() => ChunkManager.processChunk(largeChunk), throwsA(isA<RangeError>()));
    });

    test('Multiple large chunks test', () async {
      final largeChunks = List<Chunk>.generate(
        10,
        (index) => Chunk(
          data: List<int>.filled(ChunkManager.MAX_CHUNK_SIZE, 0),
        ),
      );
      for (var chunk in largeChunks) {
        expect(() => ChunkManager.processChunk(chunk), returnsNormally);
      }
    });
  });
}
