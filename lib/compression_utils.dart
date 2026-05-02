import 'dart:typed_data';
import 'package:archive/archive.dart';

class CompressionUtils {
  static List<int> compress(Uint8List data) {
    return GZipCodec().encode(data);
  }

  static double calculateCompressionRatio(int originalSize, int compressedSize) {
    return ((originalSize - compressedSize) / originalSize) * 100;
  }
}
