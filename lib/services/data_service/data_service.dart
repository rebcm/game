import 'dart:typed_data';
import 'package:rebcm/utils/compression/compression_utils.dart';

class DataService {
  Future<Uint8List> compressData(Uint8List data) async {
    return CompressionUtils.gzipCompress(data);
  }

  Future<Uint8List> decompressData(Uint8List data) async {
    return CompressionUtils.gzipDecompress(data);
  }
}
