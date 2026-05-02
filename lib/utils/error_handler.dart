import 'package:flutter/foundation.dart';

enum ErrorType { timeout, connectionError, invalidResponse }

class ErrorHandler {
  static const Map<ErrorType, String> errorMatrix = {
    ErrorType.timeout: 'retry',
    ErrorType.connectionError: 'retry',
    ErrorType.invalidResponse: 'fail-fast',
  };

  static String handleError(ErrorType errorType) {
    return errorMatrix[errorType] ?? 'fail-fast';
  }
}
