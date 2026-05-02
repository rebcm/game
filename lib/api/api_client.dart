import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;

  ApiClient(this._client);

  Future<http.Response> get(Uri url) async {
    return _client.get(url);
  }

  Future<http.Response> post(Uri url, {Object? body}) async {
    return _client.post(url, body: body);
  }
}
