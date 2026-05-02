import 'dart:convert';
import 'dart:typed_data';
import 'package:rebcm/utils/zstd.dart'; // Assuming Zstd is implemented or imported correctly

class CompressionUtils {
  static List<int> gzipCompress(Uint8List data) {
    return gzip.encode(data);
  }

  static List<int> zstdCompress(Uint8List data) {
    return Zstd.encode(data);
  }
}
