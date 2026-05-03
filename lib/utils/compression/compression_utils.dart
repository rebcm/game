import 'dart:typed_data';
import 'package:archive/archive.dart';

class CompressionUtils {
  static Uint8List gzipCompress(Uint8List data) {
    return GZipEncoder().encode(data)!;
  }

  static Uint8List gzipDecompress(Uint8List data) {
    return GZipDecoder().decodeBytes(data)!;
  }

  // Zstd implementation requires external package, so we'll stick with GZip for now
  // static Uint8List zstdCompress(Uint8List data) {
  //   // Implement Zstd compression using a suitable package
  // }

  // static Uint8List zstdDecompress(Uint8List data) {
  //   // Implement Zstd decompression using a suitable package
  // }
}
