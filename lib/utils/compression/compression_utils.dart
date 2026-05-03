import 'dart:typed_data';
import 'package:archive/archive.dart';

class CompressionUtils {
  static Uint8List gzipCompress(Uint8List data) {
    return GZipEncoder().encode(data)!;
  }

  static Uint8List gzipDecompress(Uint8List data) {
    return GZipDecoder().decodeBytes(data)!;
  }

  // For future Zstd implementation if needed
  // static Uint8List zstdCompress(Uint8List data) {
  //   // Zstd compression implementation
  // }

  // static Uint8List zstdDecompress(Uint8List data) {
  //   // Zstd decompression implementation
  // }
}
