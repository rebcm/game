import 'package:http/http.dart' as http;

class NetworkInterceptor with http.BaseClient {
  final http.Client _client;

  NetworkInterceptor(this._client);

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    try {
      return await _client.get(url, headers: headers);
    } on http.ClientException catch (e) {
      // Handle client exceptions
      return http.Response('Client error: $e', 500);
    } catch (e) {
      // Handle other exceptions
      return http.Response('Unknown error: $e', 500);
    }
  }

  @override
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body}) async {
    try {
      return await _client.post(url, headers: headers, body: body);
    } on http.ClientException catch (e) {
      // Handle client exceptions
      return http.Response('Client error: $e', 500);
    } catch (e) {
      // Handle other exceptions
      return http.Response('Unknown error: $e', 500);
    }
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) async {
    try {
      return await _client.head(url, headers: headers);
    } on http.ClientException catch (e) {
      // Handle client exceptions
      return http.Response('Client error: $e', 500);
    } catch (e) {
      // Handle other exceptions
      return http.Response('Unknown error: $e', 500);
    }
  }

  @override
  Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body}) async {
    try {
      return await _client.put(url, headers: headers, body: body);
    } on http.ClientException catch (e) {
      // Handle client exceptions
      return http.Response('Client error: $e', 500);
    } catch (e) {
      // Handle other exceptions
      return http.Response('Unknown error: $e', 500);
    }
  }

  @override
  Future<http.Response> patch(Uri url, {Map<String, String>? headers, Object? body}) async {
    try {
      return await _client.patch(url, headers: headers, body: body);
    } on http.ClientException catch (e) {
      // Handle client exceptions
      return http.Response('Client error: $e', 500);
    } catch (e) {
      // Handle other exceptions
      return http.Response('Unknown error: $e', 500);
    }
  }

  @override
  Future<http.Response> delete(Uri url, {Map<String, String>? headers, Object? body}) async {
    try {
      return await _client.delete(url, headers: headers, body: body);
    } on http.ClientException catch (e) {
      // Handle client exceptions
      return http.Response('Client error: $e', 500);
    } catch (e) {
      // Handle other exceptions
      return http.Response('Unknown error: $e', 500);
    }
  }

  @override
  void close() {
    _client.close();
  }
}
