import 'package:rebcm/networking/http_client.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  late CustomHttpClient _httpClient;

  NetworkManager() {
    _httpClient = CustomHttpClient(http.Client());
  }

  Future<http.Response> makeGetRequest(Uri url, {Map<String, String>? headers}) async {
    return _httpClient.get(url, headers: headers);
  }

  Future<http.Response> makePostRequest(Uri url, {Map<String, String>? headers, Object? body}) async {
    return _httpClient.post(url, headers: headers, body: body);
  }
}
