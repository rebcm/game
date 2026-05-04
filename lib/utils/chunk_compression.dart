import 'dart:typed_data';
import 'package:archive/archive_io.dart';

class ChunkCompression {
  static Uint8List compress(Uint8List data) {
    return GZipEncoder().encode(data);
  }

  static Uint8List decompress(Uint8List compressedData) {
    return GZipDecoder().decodeBytes(compressedData);
  }
}
