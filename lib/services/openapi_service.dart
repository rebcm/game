import 'package:http/http.dart' as http;
import 'package:openapi_client/api.dart';

class OpenApiService {
  final ApiClient _apiClient;

  OpenApiService(this._apiClient);

  Future<void> testApiConnection() async {
    final response = await _apiClient.getDefaultApi().exampleEndpoint();
    if (response.statusCode == 200) {
      print('API connection successful');
    } else {
      print('API connection failed');
    }
  }
}
