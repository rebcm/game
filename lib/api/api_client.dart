import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _httpClient;

  ApiClient(this._httpClient);

  Future<String> getData() async {
    final response = await _httpClient.get(Uri.parse('https://example.com/api/data'));
    return response.body;
  }
}
