import 'package:rebcm/services/chunk/chunk_compression_service.dart';

class CompressionUtils {
  static final _compressionService = ChunkCompressionService();

  static Uint8List compress(Uint8List data) {
    return _compressionService.compress(data);
  }

  static Uint8List decompress(Uint8List compressedData) {
    return _compressionService.decompress(compressedData);
  }
}
