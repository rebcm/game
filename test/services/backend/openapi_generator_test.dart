import 'package:test/test.dart';
import 'package:game/services/backend/openapi_generator.dart';

void main() {
  group('OpenApiGenerator', () {
    test('generateOpenApi', () {
      // Teste da geração de OpenAPI
      OpenApiGenerator.generateOpenApi();
    });
  });
}
