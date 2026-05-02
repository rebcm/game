import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/exceptions/app_exception.dart';

void main() {
  test('AppException should have message and code', () {
    final exception = AppException(message: 'Test message', code: 500);
    expect(exception.message, 'Test message');
    expect(exception.code, 500);
  });
}
