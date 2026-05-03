import 'package:test/test.dart';
import 'package:openapi_generator/openapi_generator.dart';

void main() {
  test('Chunk API contract validation', () async {
    final spec = await OpenApiSpec.fromFile('docs/api_contracts/chunk_api_contract.yaml');
    expect(spec.validate(), isTrue);
  });
}
