import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validation test with retry', (tester) async {
    int maxAttempts = 3;
    int attempt = 0;
    bool success = false;

    while (attempt < maxAttempts && !success) {
      try {
        final response = await http.get(Uri.parse('https://example.com')).timeout(Duration(seconds: 5));
        expect(response.statusCode, 200);
        success = true;
      } on SocketException catch (_) {
        attempt++;
        await Future.delayed(Duration(milliseconds: 500 * attempt));
      } on TimeoutException catch (_) {
        attempt++;
        await Future.delayed(Duration(milliseconds: 500 * attempt));
      }
    }

    expect(success, true);
  });
}
