import 'package:rebcm/compression/compression_strategy.dart';
import 'dart:convert';
import 'package:zstd/zstd.dart';

class ZstdCompression implements CompressionStrategy {
  @override
  String compress(String data) {
    final encoded = utf8.encode(data);
    final compressed = Zstd.encode(encoded);
    return base64Encode(compressed);
  }

  @override
  String decompress(String compressedData) {
    final decoded = base64Decode(compressedData);
    final decompressed = Zstd.decode(decoded);
    return utf8.decode(decompressed);
  }
}
