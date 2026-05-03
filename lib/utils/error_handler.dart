import 'package:game/services/logging/error_logger.dart';

class ErrorHandler {
  final ErrorLogger _errorLogger;

  ErrorHandler(this._errorLogger);

  void handleError(dynamic error, StackTrace? stackTrace, String context) {
    if (context == 'auth') {
      _errorLogger.logAuthError('Error during authentication', error, stackTrace);
    } else if (context == 'infrastructure') {
      _errorLogger.logInfrastructureError('Infrastructure error', error, stackTrace);
    } else if (context == 'payload') {
      _errorLogger.logPayloadError('Payload error', error, stackTrace);
    } else {
      _errorLogger.logError('Unknown error', error, stackTrace);
    }
  }
}
