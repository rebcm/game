import 'package:game/services/error_reporting/error_reporter.dart';

class ErrorHandler {
  static void handleError(dynamic error, dynamic stackTrace) {
    final errorDetails = '$error\n$stackTrace';
    print('Error occurred: $errorDetails');
    ErrorReporter.sendErrorReport(errorDetails);
  }
}
