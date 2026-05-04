import 'package:test/test.dart';
import 'package:game/utils/chunk_compression.dart';

void main() {
  test('compress and decompress', () {
    final originalData = Uint8List.fromList([1, 2, 3, 4, 5]);
    final compressedData = ChunkCompression.compress(originalData);
    final decompressedData = ChunkCompression.decompress(compressedData);
    expect(decompressedData, originalData);
  });
}
