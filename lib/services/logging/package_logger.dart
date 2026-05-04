import 'package:logger/logger.dart';

class PackageLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodIndentation: 2,
      errorMethodIndentation: 2,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void logInfo(String message) {
    _logger.i(message);
  }

  static void logError(String message, dynamic error) {
    _logger.e(message, error);
  }
}
