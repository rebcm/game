import 'package:http/http.dart' as http;

class HttpInterceptor extends http.BaseClient {
  final http.Client _client;

  HttpInterceptor(this._client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept-Encoding'] = 'gzip';
    if (request.method == 'POST') {
      request.headers['Content-Encoding'] = 'gzip';
    }
    return _client.send(request);
  }
}
