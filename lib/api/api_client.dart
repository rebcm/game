import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;

  ApiClient(this._client);

  Future<http.Response> get(String endpoint) async {
    try {
      return await _client.get(Uri.parse(endpoint));
    } on http.ClientException catch (e) {
      throw ApiException('Failed to fetch $endpoint', e);
    }
  }

  Future<http.Response> post(String endpoint, {required String body}) async {
    try {
      return await _client.post(
        Uri.parse(endpoint),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
    } on http.ClientException catch (e) {
      throw ApiException('Failed to post to $endpoint', e);
    }
  }
}

class ApiException implements Exception {
  final String message;
  final Exception cause;

  ApiException(this.message, this.cause);
}
