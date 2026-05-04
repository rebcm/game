import 'package:flutter/foundation.dart';
import 'package:game/services/error_reporting/error_reporter.dart';

class ErrorHandler with ChangeNotifier {
  static void handleError(dynamic error, dynamic stackTrace) {
    final errorLog = '$error\n$stackTrace';
    if (kReleaseMode) {
      ErrorReporter.reportError(errorLog);
    } else {
      print(errorLog);
    }
  }
}
