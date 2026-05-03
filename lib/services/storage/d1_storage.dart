import 'package:http/http.dart' as http;
import 'dart:convert';

class D1Storage {
  final http.Client _httpClient;

  D1Storage(this._httpClient);

  Future<void> deleteChunkRecord(String chunkId) async {
    final response = await _httpClient.delete(
      Uri.parse('https://your-d1-storage.com/chunks/$chunkId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete chunk record');
    }
  }
}
