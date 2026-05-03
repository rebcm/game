import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/logging/error_logger.dart';

void main() {
  group('ErrorLogger', () {
    test('logs error message', () {
      final errorLogger = ErrorLogger();
      expect(() => errorLogger.logError('Test error'), returnsNormally);
    });

    test('logs auth error message', () {
      final errorLogger = ErrorLogger();
      expect(() => errorLogger.logAuthError('Test auth error'), returnsNormally);
    });

    test('logs infrastructure error message', () {
      final errorLogger = ErrorLogger();
      expect(() => errorLogger.logInfrastructureError('Test infrastructure error'), returnsNormally);
    });

    test('logs payload error message', () {
      final errorLogger = ErrorLogger();
      expect(() => errorLogger.logPayloadError('Test payload error'), returnsNormally);
    });
  });
}
