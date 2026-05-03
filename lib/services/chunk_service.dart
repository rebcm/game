import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/chunk_request.dart';

class ChunkService {
  static const int maxRequestsPerMinute = 60;
  static const Duration oneMinute = Duration(minutes: 1);
  Map<String, List<DateTime>> _requestTimestamps = {};

  Future<http.Response> fetchChunk(ChunkRequest request) async {
    final clientIp = '127.0.0.1'; // Assuming a method to get client IP
    final now = DateTime.now();

    _requestTimestamps[clientIp] ??= [];
    _requestTimestamps[clientIp]!.removeWhere((timestamp) => now.difference(timestamp) > oneMinute);
    _requestTimestamps[clientIp]!.add(now);

    if (_requestTimestamps[clientIp]!.length > maxRequestsPerMinute) {
      return http.Response('Rate limit exceeded', 429);
    }

    final url = Uri.parse('https://example.com/chunk'); // Replace with actual URL
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(request.toJson()));

    return response;
  }
}
