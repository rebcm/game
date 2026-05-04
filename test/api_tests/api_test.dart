import 'package:flutter_test/flutter_test.dart';
import 'package:game/api/api.dart';

void main() {
  group('API Tests', () {
    test('should return successful response', () async {
      final response = await Api().getData();
      expect(response.statusCode, 200);
    });

    test('should return error response', () async {
      final response = await Api().getInvalidData();
      expect(response.statusCode, 404);
    });
  });
}
