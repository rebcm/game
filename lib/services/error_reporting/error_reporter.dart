import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dotenv/dotenv.dart';

class ErrorReporter {
  static Future<void> reportError(String errorLog) async {
    final webhookUrl = env['ERROR_WEBHOOK_URL'];
    if (webhookUrl == null) return;

    final response = await http.post(
      Uri.parse(webhookUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': 'Error Log: $errorLog'}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to report error');
    }
  }
}
