import 'package:http/http.dart' as http;

class HealthcheckService {
  Future<bool> check(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
