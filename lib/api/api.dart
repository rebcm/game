import 'package:http/http.dart' as http;

class Api {
  static Future<http.Response> get(String endpoint) async {
    return await http.get(Uri.parse('https://construcao-criativa.workers.dev$endpoint'));
  }
}
