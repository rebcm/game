import 'package:flutter_test/flutter_test.dart';
import 'api_test_strategy.dart' as strategy;

void main() {
  strategy.main();

  group('API Test Suite', () {
    test('should pass', () {
      expect(true, true);
    });
  });
}
