import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/logging/error_logger.dart';

void main() {
  test('logError logs error message', () {
    ErrorLogger.logError('Test error message');
    // Add expectation or verification logic here
  });

  test('logAuthError logs auth error message', () {
    ErrorLogger.logAuthError('Test auth error message');
    // Add expectation or verification logic here
  });

  test('logInfraError logs infra error message', () {
    ErrorLogger.logInfraError('Test infra error message');
    // Add expectation or verification logic here
  });

  test('logPayloadError logs payload error message', () {
    ErrorLogger.logPayloadError('Test payload error message');
    // Add expectation or verification logic here
  });
}
