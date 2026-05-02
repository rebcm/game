import 'package:rebcm/utils/logger.dart';

class ErrorHandler {
  static void handleError(String context, dynamic error) {
    if (error is TimeoutException) {
      Logger.logError('Timeout in $context', error);
    } else if (error is ArgumentError) {
      Logger.logError('Invalid argument in $context', error);
    } else {
      Logger.logError('Unknown error in $context', error);
    }
  }
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() {
    return 'TimeoutException: $message';
  }
}
