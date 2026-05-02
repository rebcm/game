import 'package:http/http.dart' as http;

class HttpService {
  final http.Client _client;

  HttpService(this._client);

  Future<http.Response> get(String url, {Duration timeout = const Duration(seconds: 5)}) async {
    try {
      final response = await _client.get(Uri.parse(url)).timeout(timeout);
      return response;
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } catch (e) {
      rethrow;
    }
  }
}
