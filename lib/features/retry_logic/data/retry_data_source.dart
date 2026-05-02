import 'package:http/http.dart' as http;

class RetryDataSource {
  final http.Client _client;

  RetryDataSource(this._client);

  Future<http.Response> makeRequestWithRetry(Uri url, {int retryCount = 0}) async {
    try {
      return await _client.get(url);
    } catch (e) {
      if (retryCount < 3) {
        await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));
        return makeRequestWithRetry(url, retryCount: retryCount + 1);
      } else {
        rethrow;
      }
    }
  }
}
