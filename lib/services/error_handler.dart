import 'package:rebcm/utils/logger.dart';

class ErrorHandler {
  static void handleError(String context, dynamic error) {
    if (error is HttpException) {
      Logger.logError('HTTP error in $context', error);
    } else if (error is TimeoutException) {
      Logger.logError('Timeout in $context', error);
    } else if (error is PayloadException) {
      Logger.logError('Payload error in $context', error);
    } else {
      Logger.logError('Unknown error in $context', error);
    }
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);
}

class PayloadException implements Exception {
  final String message;

  PayloadException(this.message);
}
