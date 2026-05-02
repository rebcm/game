import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;

  ApiClient({required http.Client client}) : _client = client;

  Future<void> fetchResource() async {
    final response = await _client.get(Uri.parse('https://example.com/api/resource'));

    if (response.statusCode != 200) {
      throw http.ClientException('Failed to fetch resource');
    }
  }
}
