import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackService {
  Future<void> sendFeedback(Map<String, dynamic> feedback) async {
    final url = 'https://example.com/feedback';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(feedback),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send feedback');
    }
  }
}
