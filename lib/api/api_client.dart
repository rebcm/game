import 'package:http/http.dart' as http;

class ApiClient {
  final String _baseUrl;

  ApiClient(this._baseUrl);

  Future<http.Response> getWorlds() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/worlds'));
    return response;
  }
}
