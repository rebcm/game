import 'package:http/http.dart' as http;
class MockProxyRepository {
  final http.Client _client;
  MockProxyRepository(this._client);
  Future<http.Response> interceptRequest(http.Request request) async {
    // Implement logic to intercept requests using Toxiproxy or a mock server
    return _client.send(request).then((response) => http.Response.fromStream(response));
  }
}
