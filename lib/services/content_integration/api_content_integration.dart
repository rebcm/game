import 'package:game/services/content_integration/content_integration_strategy.dart';
import 'package:http/http.dart' as http;

class ApiContentIntegration implements ContentIntegrationStrategy {
  final String _apiUrl;

  ApiContentIntegration(this._apiUrl);

  @override
  Future<String> getContent() async {
    final response = await http.get(Uri.parse(_apiUrl));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load content');
    }
  }
}
