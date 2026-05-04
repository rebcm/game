import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dotenv/dotenv.dart';

class ErrorReporter {
  static Future<void> reportError(String errorDetails) async {
    final String? webhookUrl = env['ERROR_REPORTING_WEBHOOK_URL'];
    if (webhookUrl != null && webhookUrl.isNotEmpty) {
      final response = await http.post(
        Uri.parse(webhookUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': 'Error in game: $errorDetails'}),
      );

      if (response.statusCode != 200) {
        print('Failed to send error report: ${response.statusCode}');
      }
    } else {
      print('Error reporting webhook URL is not configured.');
    }
  }
}
