import 'package:http/http.dart' as http;

class CleanupService {
  Future<void> cleanup() async {
    final response = await http.delete(Uri.parse('https://example.com/api/cleanup'));
    if (response.statusCode != 200) {
      throw Exception('Failed to cleanup');
    }
  }
}
