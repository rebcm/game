import 'package:test/test.dart';
import 'package:game/utils/compression/chunk_compression.dart';
import 'dart:typed_data';

void main() {
  test('compress and decompress', () {
    final originalData = Uint8List.fromList([1, 2, 3, 4, 5]);
    final compressedData = ChunkCompression.compress(originalData);
    final decompressedData = ChunkCompression.decompress(compressedData);
    expect(decompressedData, originalData);
  });
}
