import 'package:flutter/material.dart';
import 'package:game/services/error_reporting/error_reporter.dart';
import 'package:game/utils/error_handler.dart';
import 'package:provider/provider.dart';

void main() {
  final errorReporter = ErrorReporter('YOUR_WEBHOOK_URL');
  final errorHandler = ErrorHandler(errorReporter);

  runApp(
    MultiProvider(
      providers: [
        // existing providers...
      ],
      child: MyApp(),
    ),
  );

  FlutterError.onError = (details) {
    errorHandler.handleError(details.exception, details.stack);
  };
}
