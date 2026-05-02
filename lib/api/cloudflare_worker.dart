import 'package:http/http.dart' as http;

class CloudflareWorkerApi {
  static const String _baseUrl = 'https://construcao-criativa.workers.dev';

  Future<List<dynamic>> getUserWorlds(String userId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/worlds'),
      headers: {
        'X-User-ID': userId,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load worlds');
    }
  }
}
