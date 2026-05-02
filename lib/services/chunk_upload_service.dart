import 'package:http/http.dart' as http;

class ChunkUploadService {
  static const int maxChunkSize = 1024 * 1024; // 1MB

  final http.Client _client;

  ChunkUploadService(this._client);

  Future<void> uploadChunk(dynamic chunk) async {
    if (chunk.length > maxChunkSize) {
      throw http.ClientException('Chunk size exceeds maximum allowed size');
    }
    final response = await _client.post(Uri.parse('https://example.com/upload'), body: chunk);
    if (response.statusCode != 200) {
      throw http.ClientException('Failed to upload chunk');
    }
  }
}
