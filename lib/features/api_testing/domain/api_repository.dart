import 'package:passdriver/features/api_testing/data/api_client.dart';

class ApiRepository {
  final ApiClient _apiClient;

  ApiRepository(this._apiClient);

  Future getData() async {
    final response = await _apiClient.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }
}
