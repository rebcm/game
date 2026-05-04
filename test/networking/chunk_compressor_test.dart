import 'package:test/test.dart';
import 'package:game/networking/chunk_compressor.dart';
import 'dart:typed_data';

void main() {
  group('ChunkCompressor', () {
    test('compress and decompress', () {
      final originalData = Uint8List.fromList([1, 2, 3, 4, 5]);
      final compressedData = ChunkCompressor.compress(originalData);
      final decompressedData = ChunkCompressor.decompress(compressedData);
      expect(decompressedData, originalData);
    });
  });
}
