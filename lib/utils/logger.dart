import 'package:flutter/foundation.dart';

class Logger {
  static void logError(String message, [dynamic error]) {
    if (kDebugMode) {
      print('ERROR: $message');
      if (error != null) {
        print(error);
      }
    }
  }

  static void logInfo(String message) {
    if (kDebugMode) {
      print('INFO: $message');
    }
  }
}
