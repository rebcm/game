import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Retry and Timeout Test', (tester) async {
    final url = Uri.parse('https://example.com');
    final response = await http.get(url).timeout(
      const Duration(seconds: 10),
      onTimeout: () => http.Response('Timeout', 408),
    ).retry(3);

    expect(response.statusCode, anyOf([200, 408]));
  });
}
