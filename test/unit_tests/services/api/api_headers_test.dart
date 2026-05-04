import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api/api_headers.dart';

void main() {
  group('ApiHeaders', () {
    test('getAuthorizationHeader should return correct headers', () {
      final token = 'test_token';
      final headers = ApiHeaders.getAuthorizationHeader(token);
      expect(headers['Authorization'], 'Bearer $token');
      expect(headers['Content-Type'], 'application/json');
    });

    test('getContentTypeHeader should return correct headers', () {
      final headers = ApiHeaders.getContentTypeHeader();
      expect(headers['Content-Type'], 'application/json');
      expect(headers.length, 1);
    });
  });
}
