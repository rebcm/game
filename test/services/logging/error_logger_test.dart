import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/logging/error_logger.dart';

void main() {
  group('ErrorLogger', () {
    test('logs error with message, error, and stackTrace', () {
      final errorLogger = ErrorLogger();
      final error = Exception('Test Error');
      final stackTrace = StackTrace.current;

      expect(() => errorLogger.logError('Test Message', error, stackTrace), returnsNormally);
    });
  });
}
