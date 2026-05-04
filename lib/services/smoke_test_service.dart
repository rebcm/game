import 'package:http/http.dart' as http;

class SmokeTestService {
  Future<bool> checkSmokeTestStatus() async {
    final response = await http.get(Uri.parse('https://example.com/smoke-test-endpoint'));
    return response.statusCode == 200;
  }
}
