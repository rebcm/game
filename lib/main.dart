import 'package:flutter/material.dart';
import 'package:game/services/notification/notification_service.dart';
import 'package:game/utils/error_handling/error_handler.dart';

void main() {
  final notificationService = NotificationService('YOUR_WEBHOOK_URL');
  final errorHandler = ErrorHandler(notificationService);

  FlutterError.onError = (details) {
    errorHandler.handleError(details.exception, details.stack);
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: Scaffold(
        body: Center(
          child: Text('Rebeca\'s Game'),
        ),
      ),
    );
  }
}
