import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/compression_utils.dart';

void main() {
  test('compresses data correctly', () {
    final originalData = Uint8List.fromList([1, 2, 3, 4, 5]);
    final compressedData = CompressionUtils.compress(originalData);
    expect(compressedData.length, lessThan(originalData.length));
  });

  test('calculates compression ratio correctly', () {
    final originalSize = 100;
    final compressedSize = 50;
    final ratio = CompressionUtils.calculateCompressionRatio(originalSize, compressedSize);
    expect(ratio, 50);
  });
}
