import 'package:rebcm/compression/compression_strategy.dart';
import 'dart:convert';
import 'package:archive/archive_io.dart';

class GZipCompression implements CompressionStrategy {
  @override
  String compress(String data) {
    final encoded = utf8.encode(data);
    final compressed = GZipEncoder().encode(encoded);
    return base64Encode(compressed!);
  }

  @override
  String decompress(String compressedData) {
    final decoded = base64Decode(compressedData);
    final decompressed = GZipDecoder().decodeBytes(decoded);
    return utf8.decode(decompressed);
  }
}
