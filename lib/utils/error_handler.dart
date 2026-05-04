import 'package:flutter/foundation.dart';
import 'package:game/services/error_reporting/error_reporter.dart';

class ErrorHandler with ChangeNotifier {
  static void handleError(dynamic error, dynamic stackTrace) {
    final String errorDetails = '$error\n$stackTrace';
    if (kDebugMode) {
      print(errorDetails);
    }
    ErrorReporter.reportError(errorDetails);
  }
}
