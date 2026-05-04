import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dotenv/dotenv.dart';

class ErrorNotifier {
  static Future<void> sendErrorNotification(String errorDetails) async {
    final webhookUrl = env['ERROR_WEBHOOK_URL'];
    if (webhookUrl != null) {
      final response = await http.post(
        Uri.parse(webhookUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': errorDetails}),
      );
      if (response.statusCode != 200) {
        print('Failed to send error notification: ${response.statusCode}');
      }
    } else {
      print('ERROR_WEBHOOK_URL is not configured');
    }
  }
}
