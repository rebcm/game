import 'package:flutter/foundation.dart';
import 'package:game/services/notifications/error_notifier.dart';

class ErrorHandler with ChangeNotifier {
  static void handleError(dynamic error, dynamic stackTrace) {
    final errorDetails = '$error\n$stackTrace';
    if (kReleaseMode) {
      ErrorNotifier.sendErrorNotification(errorDetails);
    } else {
      print(errorDetails);
    }
  }
}
