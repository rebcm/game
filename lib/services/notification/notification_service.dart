import 'package:http/http.dart' as http;

class NotificationService {
  final String _webhookUrl;

  NotificationService(this._webhookUrl);

  Future<void> sendErrorNotification(String errorLog) async {
    final response = await http.post(
      Uri.parse(_webhookUrl),
      headers: {'Content-Type': 'application/json'},
      body: '{"text": "$errorLog"}',
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send error notification');
    }
  }
}
