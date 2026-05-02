import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final String _baseUrl;

  ApiClient(this._baseUrl);

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      return await http.post(
        Uri.parse('$_baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    } on http.ClientException catch (e) {
      // Handle network errors
      rethrow;
    }
  }
}
