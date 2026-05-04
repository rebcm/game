import 'package:flutter_test/flutter_test.dart';
import 'package:game/api/api.dart';

void main() {
  group('Load Tests', () {
    test('should handle multiple requests', () async {
      for (var i = 0; i < 100; i++) {
        final response = await Api().getData();
        expect(response.statusCode, 200);
      }
    });
  });
}
