import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _httpClient;

  ApiClient(this._httpClient);

  Future<String> fetchData() async {
    final response = await _httpClient.get(Uri.parse('https://example.com/api/data'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
