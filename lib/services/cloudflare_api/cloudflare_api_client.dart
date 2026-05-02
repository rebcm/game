import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudflareApiClient {
  final http.Client _httpClient;

  CloudflareApiClient(this._httpClient);

  Future<http.Response> makeRequest(Uri uri) async {
    return await _httpClient.get(uri);
  }
}
