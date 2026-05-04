import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('retry policy test', (tester) async {
    final url = Uri.parse('https://example.com');
    final response = await retryHttpRequest(() => http.get(url), retries: 3, initialDelay: Duration(seconds: 1));
    expect(response.statusCode, 200);
  });
}

Future<http.Response> retryHttpRequest(Future<http.Response> Function() request, {required int retries, required Duration initialDelay}) async {
  int attempt = 0;
  Duration delay = initialDelay;

  while (attempt < retries) {
    try {
      return await request();
    } on SocketException catch (e) {
      if (attempt == retries - 1) rethrow;
      await Future.delayed(delay);
      delay *= 2;
      attempt++;
    }
  }
  throw Exception('Failed after $retries attempts');
}
