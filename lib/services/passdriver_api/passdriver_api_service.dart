import 'package:http/http.dart' as http;

class PassdriverApiService {
  final String _baseUrl = 'https://api.exemplo.com';

  Future<http.Response> exemploEndpoint() async {
    final url = Uri.parse('$_baseUrl/api/exemplo');
    final response = await http.get(url);

    return response;
  }
}
