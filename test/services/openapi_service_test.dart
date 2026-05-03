import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/openapi_service.dart';
import 'package:openapi_client/api.dart';

void main() {
  test('test API connection', () async {
    final apiClient = ApiClient(basePath: 'https://example.com/api');
    final openApiService = OpenApiService(apiClient);
    await openApiService.testApiConnection();
  });
}
