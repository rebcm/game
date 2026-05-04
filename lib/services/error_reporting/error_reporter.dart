import 'package:http/http.dart' as http;

class ErrorReporter {
  final String _webhookUrl;

  ErrorReporter(this._webhookUrl);

  Future<void> reportError(String errorDetails) async {
    final response = await http.post(
      Uri.parse(_webhookUrl),
      headers: {'Content-Type': 'application/json'},
      body: '{"text": "$errorDetails"}',
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to report error');
    }
  }
}
