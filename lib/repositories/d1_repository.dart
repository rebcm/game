import 'package:http/http.dart' as http;
import 'package:rebcm/models/chunk_model.dart';

class D1Repository {
  final http.Client _httpClient;

  D1Repository(this._httpClient);

  Future<void> deleteChunkRecord(String chunkId) async {
    final response = await _httpClient.delete(
      Uri.parse('https://example-d1.com/chunks/$chunkId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete chunk record');
    }
  }
}
