import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/compression/compression_utils.dart';
import 'dart:typed_data';

void main() {
  group('CompressionUtils', () {
    test('gzipCompress and gzipDecompress', () {
      final originalData = Uint8List.fromList([1, 2, 3, 4, 5]);
      final compressedData = CompressionUtils.gzipCompress(originalData);
      final decompressedData = CompressionUtils.gzipDecompress(compressedData);
      expect(decompressedData, originalData);
    });
  });
}
