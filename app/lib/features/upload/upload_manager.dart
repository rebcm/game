import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadManager {
  Future<http.Response> uploadChunks(List chunkData) async {
    final response = await http.post(
      Uri.parse('https://construcao-criativa.workers.dev/upload'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(chunkData),
    );
    return response;
  }

  Future<http.Response> uploadLargeFile(List largeData) async {
    final response = await http.post(
      Uri.parse('https://construcao-criativa.workers.dev/upload'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(largeData),
    );
    return response;
  }
}
