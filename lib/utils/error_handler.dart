import 'package:rebcm/services/logging/error_logger.dart';

class ErrorHandler {
  final ErrorLogger _errorLogger;

  ErrorHandler(this._errorLogger);

  void handleError(dynamic error, StackTrace stackTrace) {
    if (error.toString().contains('auth')) {
      _errorLogger.logAuthError(error, stackTrace);
    } else if (error.toString().contains('network') || error.toString().contains('socket')) {
      _errorLogger.logInfrastructureError(error, stackTrace);
    } else {
      _errorLogger.logPayloadError(error, stackTrace);
    }
  }
}
