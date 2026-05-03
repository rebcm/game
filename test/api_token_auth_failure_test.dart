import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/api_service.dart';

void main() {
  test('API token auth failure test', () async {
    // Simulate API token auth failure
    final apiService = ApiService(http.Client(), 'invalid_token');
    final response = await apiService.makeRequest();
    expect(response.statusCode, 401);
  });
}
