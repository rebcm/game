import 'package:http/http.dart' as http;

class ChunkUploadService {
  final http.Client _client;

  ChunkUploadService(this._client);

  Future<void> uploadChunk(String chunk) async {
    final response = await _client.post(Uri.parse('https://example.com/upload'), body: chunk);
    if (response.statusCode != 200) {
      throw http.ClientException('Failed to upload chunk: ${response.statusCode}');
    }
  }
}
