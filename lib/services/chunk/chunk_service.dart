import 'package:http/http.dart' as http;
import 'dart:convert';

class ChunkService {
  final http.Client _httpClient;
  final Map<String, int> _requestTimestamps = {};

  ChunkService(this._httpClient);

  Future<String> fetchChunk(String chunkId) async {
    if (_isRateLimited(chunkId)) {
      throw Exception('Rate limit exceeded for chunk $chunkId');
    }
    _recordRequest(chunkId);
    final response = await _httpClient.get(Uri.parse('https://example.com/chunks/$chunkId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load chunk $chunkId');
    }
  }

  bool _isRateLimited(String chunkId) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final lastRequest = _requestTimestamps[chunkId];
    if (lastRequest != null && now - lastRequest < 1000) {
      return true;
    }
    return false;
  }

  void _recordRequest(String chunkId) {
    _requestTimestamps[chunkId] = DateTime.now().millisecondsSinceEpoch;
  }
}
