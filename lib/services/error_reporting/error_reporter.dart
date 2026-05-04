import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';

class ErrorReporter {
  static Future<void> reportError(String errorLog) async {
    final webhookUrl = env['ERROR_WEBHOOK_URL'];
    if (webhookUrl != null && webhookUrl.isNotEmpty) {
      final response = await http.post(Uri.parse(webhookUrl), headers: {
        'Content-Type': 'application/json',
      }, body: '{"text": "$errorLog"}');
      if (response.statusCode != 200) {
        print('Failed to send error report: ${response.statusCode}');
      }
    } else {
      print('Error webhook URL is not configured');
    }
  }
}
