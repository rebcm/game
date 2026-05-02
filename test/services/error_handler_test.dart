import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/error_handler.dart';

void main() {
  test('ErrorHandler handleError', () {
    ErrorHandler.handleError('Test context', TimeoutException('Test timeout'));
    ErrorHandler.handleError('Test context', ArgumentError('Test argument error'));
    ErrorHandler.handleError('Test context', Exception('Test unknown error'));
  });
}
