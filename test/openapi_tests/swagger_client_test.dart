import 'package:flutter_test/flutter_test.dart';
import 'package:game/openapi/generated/swagger.dart';

void main() {
  test('Test Swagger Client', () async {
    final apiClient = ApiClient();
    final swaggerService = SwaggerService(apiClient);
    await swaggerService.fetchData();
    // Verify results
  });
}
