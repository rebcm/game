import 'package:flutter/foundation.dart';
import 'package:game/services/error_reporting/error_reporter.dart';

class ErrorHandler with ChangeNotifier {
  final ErrorReporter _errorReporter;

  ErrorHandler(this._errorReporter);

  void handleError(Object error, StackTrace stackTrace) {
    final errorDetails = '$error\n$stackTrace';
    _errorReporter.reportError(errorDetails);
  }
}
