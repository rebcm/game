import 'package:http/http.dart' as http;

class CustomHttpClient {
  final http.Client _client;

  CustomHttpClient(this._client);

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final defaultHeaders = {
      'Accept-Encoding': 'gzip',
    };
    final mergedHeaders = {...?headers, ...defaultHeaders};
    return _client.get(url, headers: mergedHeaders);
  }

  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body}) async {
    final defaultHeaders = {
      'Content-Encoding': 'gzip',
      'Accept-Encoding': 'gzip',
    };
    final mergedHeaders = {...?headers, ...defaultHeaders};
    return _client.post(url, headers: mergedHeaders, body: body);
  }
}
