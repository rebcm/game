import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FeedbackService {
  Future<bool> submitFeedback(String step, String issue, String suggestion) async {
    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL']}/feedback'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'step': step,
        'issue': issue,
        'suggestion': suggestion,
      }),
    );
    return response.statusCode == 201;
  }
}
