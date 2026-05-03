import 'package:http/http.dart' as http;
import 'package:rebcm/models/chunk_model.dart';

class R2Repository {
  final http.Client _httpClient;

  R2Repository(this._httpClient);

  Future<void> uploadChunk(ChunkModel chunk) async {
    final response = await _httpClient.post(
      Uri.parse('https://example-r2.com/chunks'),
      body: chunk.toJson(),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to upload chunk');
    }
  }
}
