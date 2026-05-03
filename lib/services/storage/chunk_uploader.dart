import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rebcm/models/chunk_model.dart';

class ChunkUploader {
  final http.Client _httpClient;

  ChunkUploader(this._httpClient);

  Future<bool> uploadChunk(ChunkModel chunk) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('https://example.com/upload-chunk'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(chunk.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
