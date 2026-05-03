import 'package:http/http.dart' as http;
import 'package:rebcm/models/chunk_request.dart';
import 'dart:convert';

class ChunkService {
  final http.Client _httpClient;
  final Map<String, int> _requestTimestamps = {};

  ChunkService(this._httpClient);

  Future<void> fetchChunk(ChunkRequest request) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final key = '${request.x},${request.z}';
    final lastRequest = _requestTimestamps[key];

    if (lastRequest != null && now - lastRequest < 500) {
      return;
    }

    _requestTimestamps[key] = now;

    final response = await _httpClient.get(Uri.parse('https://example.com/chunks/${request.x}/${request.z}'));

    if (response.statusCode == 200) {
      // Process the chunk data
      print('Chunk fetched: ${request.x}, ${request.z}');
    } else {
      print('Failed to fetch chunk: ${response.statusCode}');
    }
  }
}
