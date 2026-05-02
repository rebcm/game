import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _httpClient;

  ApiClient(this._httpClient);

  Future<String> fetchData(String token) async {
    if (token == null) {
      throw ArgumentError('Token cannot be null');
    }

    if (token.length > 1000) {
      throw ArgumentError('Token exceeds character limit');
    }

    try {
      final response = await _httpClient.get(Uri.parse('https://example.com/api/data'));
      if (response.statusCode == 401) {
        throw Exception('Token expired or unauthorized');
      }
      return response.body;
    } on SocketException {
      throw Exception('Network connection failed');
    }
  }
}
