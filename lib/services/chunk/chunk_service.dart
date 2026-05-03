import 'package:http/http.dart' as http;
import 'package:rebcm/utils/compression/compression_utils.dart';

class ChunkService {
  Future<void> uploadChunk(Uint8List chunkData) async {
    final compressedData = CompressionUtils.compress(chunkData);
    final response = await http.post(Uri.parse('https://example.com/upload'), body: compressedData);
    if (response.statusCode != 200) {
      throw Exception('Failed to upload chunk');
    }
  }

  Future<Uint8List> downloadChunk() async {
    final response = await http.get(Uri.parse('https://example.com/download'));
    if (response.statusCode == 200) {
      return CompressionUtils.decompress(response.bodyBytes);
    } else {
      throw Exception('Failed to download chunk');
    }
  }
}
