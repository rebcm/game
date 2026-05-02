import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/services/logging/error_logger.dart';
import 'package:rebcm/utils/error_handler.dart';

class MockErrorLogger extends Mock implements ErrorLogger {}

void main() {
  group('ErrorHandler', () {
    late ErrorHandler errorHandler;
    late MockErrorLogger mockErrorLogger;

    setUp(() {
      mockErrorLogger = MockErrorLogger();
      errorHandler = ErrorHandler(mockErrorLogger);
    });

    test('handles auth error', () {
      final error = Exception('auth error');
      final stackTrace = StackTrace.current;

      when(() => mockErrorLogger.logAuthError(error, stackTrace)).thenReturn(null);

      errorHandler.handleError(error, stackTrace);

      verify(() => mockErrorLogger.logAuthError(error, stackTrace)).called(1);
    });

    test('handles infrastructure error', () {
      final error = Exception('network error');
      final stackTrace = StackTrace.current;

      when(() => mockErrorLogger.logInfrastructureError(error, stackTrace)).thenReturn(null);

      errorHandler.handleError(error, stackTrace);

      verify(() => mockErrorLogger.logInfrastructureError(error, stackTrace)).called(1);
    });

    test('handles payload error', () {
      final error = Exception('payload error');
      final stackTrace = StackTrace.current;

      when(() => mockErrorLogger.logPayloadError(error, stackTrace)).thenReturn(null);

      errorHandler.handleError(error, stackTrace);

      verify(() => mockErrorLogger.logPayloadError(error, stackTrace)).called(1);
    });
  });
}
