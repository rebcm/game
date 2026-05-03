import 'package:game/services/logging/error_logger.dart';

class ErrorHandling {
  final ErrorLogger _errorLogger;

  ErrorHandling(this._errorLogger);

  void handleError(dynamic error) {
    if (error is AuthException) {
      _errorLogger.logAuthError('Authentication error', error);
    } else if (error is InfrastructureException) {
      _errorLogger.logInfrastructureError('Infrastructure error', error);
    } else if (error is PayloadException) {
      _errorLogger.logPayloadError('Payload error', error);
    } else {
      _errorLogger.logError('Unknown error', error);
    }
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class InfrastructureException implements Exception {
  final String message;

  InfrastructureException(this.message);
}

class PayloadException implements Exception {
  final String message;

  PayloadException(this.message);
}
