import 'package:rebcm/services/logging/error_logger.dart';

class ErrorHandler {
  static void handleError(dynamic error, StackTrace? stackTrace) {
    if (error is AuthException) {
      ErrorLogger.logAuthError(error.message, error, stackTrace);
    } else if (error is InfraException) {
      ErrorLogger.logInfraError(error.message, error, stackTrace);
    } else if (error is PayloadException) {
      ErrorLogger.logPayloadError(error.message, error, stackTrace);
    } else {
      ErrorLogger.logError('Unknown error: ${error.toString()}', error, stackTrace);
    }
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class InfraException implements Exception {
  final String message;

  InfraException(this.message);
}

class PayloadException implements Exception {
  final String message;

  PayloadException(this.message);
}
