import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/notification/notification_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('sendErrorNotification sends error log to webhook', () async {
    final mockHttpClient = MockClient((request) async {
      if (request.url.toString() == 'YOUR_WEBHOOK_URL') {
        return http.Response('', 200);
      } else {
        return http.Response('Not Found', 404);
      }
    });

    http.Client client = http.Client();
    http.Client originalClient = http.Client();
    http.Client = () => mockHttpClient;

    final notificationService = NotificationService('YOUR_WEBHOOK_URL');
    await notificationService.sendErrorNotification('Test error log');

    http.Client = () => originalClient;
  });

  test('sendErrorNotification throws exception on failure', () async {
    final mockHttpClient = MockClient((request) async {
      return http.Response('Internal Server Error', 500);
    });

    http.Client client = http.Client();
    http.Client originalClient = http.Client();
    http.Client = () => mockHttpClient;

    final notificationService = NotificationService('YOUR_WEBHOOK_URL');
    expect(() async => await notificationService.sendErrorNotification('Test error log'), throwsException);

    http.Client = () => originalClient;
  });
}
