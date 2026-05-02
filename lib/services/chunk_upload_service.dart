import 'package:http/http.dart' as http;

class ChunkUploadService {
  static const int maxChunkSize = 1024 * 1024; // 1MB
  final http.Client _httpClient;

  ChunkUploadService(this._httpClient);

  Future<void> uploadChunk(dynamic chunk) async {
    if (chunk.length > maxChunkSize) {
      throw http.ClientException('Chunk size exceeds maximum allowed size');
    }

    try {
      final response = await _httpClient.post(Uri.parse('https://example.com/upload'), body: chunk);

      if (response.statusCode != 200) {
        throw http.ClientException('Failed to upload chunk');
      }
    } on http.ClientException catch (e) {
      throw http.ClientException('Error uploading chunk: $e');
    }
  }
}
