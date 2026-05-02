import 'package:http/http.dart' as http;

class CleanupUtils {
  static Future<void> rollbackChanges() async {
    final response = await http.post(
      Uri.parse('https://construcao-criativa.workers.dev/cleanup'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '{}',
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cleanup: ${response.statusCode}');
    }
  }
}
