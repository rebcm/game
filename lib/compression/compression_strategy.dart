import 'package:rebcm/compression/gzip_compression.dart';
import 'package:rebcm/compression/zstd_compression.dart';

abstract class CompressionStrategy {
  String compress(String data);
  String decompress(String compressedData);

  factory CompressionStrategy.fromType(CompressionType type) {
    switch (type) {
      case CompressionType.gzip:
        return GZipCompression();
      case CompressionType.zstd:
        return ZstdCompression();
    }
  }
}

enum CompressionType { gzip, zstd }
