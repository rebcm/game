import 'package:flutter/foundation.dart';

class PerformanceLogger {
  static void log(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
