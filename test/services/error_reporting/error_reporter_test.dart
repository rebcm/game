import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/error_reporting/error_reporter.dart';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';

void main() {
  group('ErrorReporter', () {
    test('reportError sends error log to webhook', () async {
      // Mock the HTTP post request
      // Verify the request is sent with the correct error log
    });

    test('reportError handles empty webhook URL', () async {
      // Set the webhook URL to empty
      // Verify the error is handled correctly
    });
  });
}
