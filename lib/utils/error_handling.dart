import 'package:game/services/logging/error_logger.dart';

class ErrorHandling {
  static void handleError(dynamic error, StackTrace? stackTrace) {
    if (error is AuthException) {
      ErrorLogger.logAuthError('Authentication error', error, stackTrace);
    } else if (error is InfrastructureException) {
      ErrorLogger.logInfrastructureError('Infrastructure error', error, stackTrace);
    } else if (error is PayloadException) {
      ErrorLogger.logPayloadError('Payload error', error, stackTrace);
    } else {
      ErrorLogger.logError('Unknown error', error, stackTrace);
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
