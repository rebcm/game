import 'package:game/openapi/client/api_client.dart';

class ApiService {
  final ApiClient _apiClient;

  ApiService(this._apiClient);

  Future<void> testEndpoint() async {
    final response = await _apiClient.get(Uri.parse('https://example.com/api/endpoint'));
    if (response.statusCode == 200) {
      print('Endpoint responded successfully');
    } else {
      print('Endpoint failed to respond');
    }
  }
}
