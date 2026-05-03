import 'package:http/http.dart' as http;

class OpenApiClient {
  final http.Client _client;

  OpenApiClient(this._client);

  Future<http.Response> example() async {
    return await _client.get(Uri.parse('https://example.com/example'));
  }
}
