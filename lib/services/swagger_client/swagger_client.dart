import 'package:http/http.dart' as http;

class SwaggerClient {
  final String _baseUrl;

  SwaggerClient(this._baseUrl);

  Future<http.Response> getSwaggerJson() async {
    return await http.get(Uri.parse('$_baseUrl/swagger.json'));
  }
}
