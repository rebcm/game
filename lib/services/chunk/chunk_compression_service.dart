import 'package:archive/archive.dart';
import 'dart:typed_data';

class ChunkCompressionService {
  Uint8List compress(Uint8List data) {
    return GZipEncoder().encode(data);
  }

  Uint8List decompress(Uint8List compressedData) {
    return GZipDecoder().decodeBytes(compressedData);
  }
}
