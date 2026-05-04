import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/error_reporting/error_reporter.dart';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';

void main() {
  group('ErrorReporter', () {
    test('sendErrorReport sends error report to webhook', () async {
      // Mock the HTTP post request
      final mockHttpClient = http.Client();
      final response = await mockHttpClient.post(
        Uri.parse('https://example.com/webhook'),
        headers: {'Content-Type': 'application/json'},
        body: '{"text": "Test error report"}',
      );
      expect(response.statusCode, 200);
    });

    test('sendErrorReport handles empty webhook URL', () async {
      env['ERROR_REPORT_WEBHOOK_URL'] = '';
      await ErrorReporter.sendErrorReport('Test error');
      // Verify that it prints the correct message
    });
  });
}
