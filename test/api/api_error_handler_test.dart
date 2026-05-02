import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:rebcm/api/api_error_handler.dart';

void main() {
  group('ApiErrorHandler', () {
    test('handleError returns correct message for 401', () {
      final response = Response('{}', 401);

      final result = ApiErrorHandler.handleError(response);

      expect(result, 'Unauthorized');
    });

    test('handleError returns correct message for 404', () {
      final response = Response('{}', 404);

      final result = ApiErrorHandler.handleError(response);

      expect(result, 'Not Found');
    });

    test('handleError returns correct message for 500', () {
      final response = Response('{}', 500);

      final result = ApiErrorHandler.handleError(response);

      expect(result, 'Internal Server Error');
    });

    test('handleError returns Unknown Error for other status codes', () {
      final response = Response('{}', 999);

      final result = ApiErrorHandler.handleError(response);

      expect(result, 'Unknown Error');
    });
  });
}
