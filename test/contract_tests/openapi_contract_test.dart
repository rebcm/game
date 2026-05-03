import 'package:flutter_test/flutter_test.dart';
import 'package:openapi_generator/openapi_generator.dart';

void main() {
  test('validate OpenAPI contract', () async {
    final openapi = OpenApi.load('docs/api_contract/openapi.yaml');
    expect(openapi.validate(), isTrue);
  });
}
