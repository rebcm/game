import 'package:http/http.dart' as http;

class CustomHttpClient {
  final http.Client _client;

  CustomHttpClient(this._client);

  Future<http.Response> get(Uri url) async {
    final response = await _client.get(
      url,
      headers: {
        'Accept-Encoding': 'gzip',
      },
    );

    return _handleResponse(response);
  }

  Future<http.Response> post(Uri url, {Object? body}) async {
    final response = await _client.post(
      url,
      headers: {
        'Content-Encoding': 'gzip',
        'Accept-Encoding': 'gzip',
      },
      body: body,
    );

    return _handleResponse(response);
  }

  http.Response _handleResponse(http.Response response) {
    if (response.headers['content-encoding'] == 'gzip') {
      // Assuming a gzip decoding function is implemented elsewhere
      // For simplicity, this example doesn't handle gzip decoding
      return response;
    } else {
      return response;
    }
  }
}
