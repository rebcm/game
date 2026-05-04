import 'package:flutter/foundation.dart';
import 'package:game/services/notification/notification_service.dart';

class ErrorHandler with ChangeNotifier {
  final NotificationService _notificationService;

  ErrorHandler(this._notificationService);

  void handleError(dynamic error, dynamic stackTrace) {
    final errorLog = '$error\n$stackTrace';
    _notificationService.sendErrorNotification(errorLog);
    if (kDebugMode) {
      print(errorLog);
    }
  }
}
