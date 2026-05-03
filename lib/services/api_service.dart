import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<http.Response> validateR2Reference() async {
    final url = Uri.parse('https://example-r2-bucket.com/resource');
    return _client.get(url);
  }
}
