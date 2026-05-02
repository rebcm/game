import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/api/api_parser.dart';

void main() {
  group('ApiParser', () {
    test('parseData returns correct data when JSON is valid', () {
      final jsonData = '{"data": "test"}';
      final result = ApiParser.parseData(jsonData);
      expect(result, 'test');
    });

    test('parseData throws exception when JSON is invalid', () {
      final jsonData = 'invalid json';
      expect(() => ApiParser.parseData(jsonData), throwsException);
    });
  });
}
