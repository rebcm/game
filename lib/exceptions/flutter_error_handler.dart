import 'package:flutter/material.dart';
import 'package:rebcm/exceptions/app_exception.dart';

class FlutterErrorHandler {
  static void handleError(Object error) {
    if (error is AppException) {
      // Handle AppException
      debugPrint('AppException: ${error.message} (${error.code})');
    } else {
      // Handle other errors
      debugPrint('Error: $error');
    }
  }
}
