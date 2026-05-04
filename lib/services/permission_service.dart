import 'package:http/http.dart' as http;

class PermissionService {
  final http.Client _client;

  PermissionService(this._client);

  Future<http.Response> makeRequest() async {
    final response = await _client.get(Uri.parse('https://example.com/api/test'));
    return response;
  }
}
