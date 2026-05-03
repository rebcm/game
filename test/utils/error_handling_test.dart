import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/logging/error_logger.dart';
import 'package:game/utils/error_handling.dart';

void main() {
  group('ErrorHandling', () {
    late ErrorLogger errorLogger;
    late ErrorHandling errorHandling;

    setUp(() {
      errorLogger = ErrorLogger();
      errorHandling = ErrorHandling(errorLogger);
    });

    test('handles auth exception', () {
      final authException = AuthException('Test auth exception');
      expect(() => errorHandling.handleError(authException), returnsNormally);
    });

    test('handles infrastructure exception', () {
      final infrastructureException = InfrastructureException('Test infrastructure exception');
      expect(() => errorHandling.handleError(infrastructureException), returnsNormally);
    });

    test('handles payload exception', () {
      final payloadException = PayloadException('Test payload exception');
      expect(() => errorHandling.handleError(payloadException), returnsNormally);
    });

    test('handles unknown exception', () {
      final unknownException = Exception('Test unknown exception');
      expect(() => errorHandling.handleError(unknownException), returnsNormally);
    });
  });
}
