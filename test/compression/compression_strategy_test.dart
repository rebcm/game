import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/compression/compression_strategy.dart';
import 'package:rebcm/compression/gzip_compression.dart';
import 'package:rebcm/compression/zstd_compression.dart';

void main() {
  group('CompressionStrategy', () {
    test('GZipCompression compress and decompress', () {
      final strategy = GZipCompression();
      final data = 'test data';
      final compressed = strategy.compress(data);
      final decompressed = strategy.decompress(compressed);
      expect(decompressed, data);
    });

    test('ZstdCompression compress and decompress', () {
      final strategy = ZstdCompression();
      final data = 'test data';
      final compressed = strategy.compress(data);
      final decompressed = strategy.decompress(compressed);
      expect(decompressed, data);
    });

    test('CompressionStrategy.fromType', () {
      expect(CompressionStrategy.fromType(CompressionType.gzip), isA<GZipCompression>());
      expect(CompressionStrategy.fromType(CompressionType.zstd), isA<ZstdCompression>());
    });
  });
}
