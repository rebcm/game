import 'package:flutter/foundation.dart';

class ErrorLogger {
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('ERROR: $message');
      if (error != null) {
        print('Error: $error');
      }
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }

  void logAuthError(String message, [dynamic error, StackTrace? stackTrace]) {
    logError('AUTH ERROR: $message', error, stackTrace);
  }

  void logInfrastructureError(String message, [dynamic error, StackTrace? stackTrace]) {
    logError('INFRASTRUCTURE ERROR: $message', error, stackTrace);
  }

  void logPayloadError(String message, [dynamic error, StackTrace? stackTrace]) {
    logError('PAYLOAD ERROR: $message', error, stackTrace);
  }
}
