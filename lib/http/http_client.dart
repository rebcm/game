import 'package:http/http.dart' as http;

class HttpClient {
  static http.Client client = http.Client();

  static Future<http.Response> get(Uri url) async {
    return await client.get(url);
  }

  static Future<http.Response> post(Uri url, {Object? body}) async {
    return await client.post(url, body: body);
  }
}
