import 'package:http/http.dart' as http;

class WorldApi {
  static const String _baseUrl = 'https://construcao-criativa.workers.dev/api';

  Future<http.Response> createWorld(String userId, String worldData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/worlds'),
      headers: {
        'Content-Type': 'application/json',
        'X-User-Id': userId,
      },
      body: worldData,
    );
    return response;
  }
}
