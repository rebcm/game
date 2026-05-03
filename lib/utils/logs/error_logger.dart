import 'package:flutter/foundation.dart';

class ErrorLogger {
  static void logError(String errorType, dynamic error, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      print('[$errorType] $error');
      if (stackTrace != null) {
        print(stackTrace);
      }
    }
  }

  static void logAuthError(dynamic error, {StackTrace? stackTrace}) {
    logError('AUTH_ERROR', error, stackTrace: stackTrace);
  }

  static void logInfraError(dynamic error, {StackTrace? stackTrace}) {
    logError('INFRA_ERROR', error, stackTrace: stackTrace);
  }

  static void logPayloadError(dynamic error, {StackTrace? stackTrace}) {
    logError('PAYLOAD_ERROR', error, stackTrace: stackTrace);
  }
}
