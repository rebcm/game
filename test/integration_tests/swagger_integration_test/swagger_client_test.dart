import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/swagger_client/swagger_client.dart';

void main() {
  test('Test Swagger Client', () async {
    final client = SwaggerClient('https://rebcm.github.io/game');
    final response = await client.getSwaggerJson();
    expect(response.statusCode, 200);
  });
}
