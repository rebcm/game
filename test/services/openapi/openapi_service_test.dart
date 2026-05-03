import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/openapi/openapi_service.dart';

void main() {
  group('OpenApiService', () {
    test('loads OpenAPI doc', () async {
      final service = OpenApiService();
      await service.loadOpenApiDoc();
      expect(service.openApiDoc, isNotEmpty);
    });
  });
}
