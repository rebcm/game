import 'package:game/domain/content_provider/content_provider.dart';
import 'package:http/http.dart' as http;

class ApiContentProvider implements ContentProvider {
  @override
  Future<String> getTip() async {
    final response = await http.get(Uri.parse('https://example.com/tip'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load tip');
    }
  }
}
