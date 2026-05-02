import 'package:flutter/foundation.dart';

class ErrorLogger {
  void logError(String message, dynamic error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('Error: $message - $error');
      print(stackTrace);
    }
  }

  void logAuthError(dynamic error, StackTrace stackTrace) {
    logError('Authentication Error', error, stackTrace);
  }

  void logInfrastructureError(dynamic error, StackTrace stackTrace) {
    logError('Infrastructure Error', error, stackTrace);
  }

  void logPayloadError(dynamic error, StackTrace stackTrace) {
    logError('Payload Error', error, stackTrace);
  }
}
