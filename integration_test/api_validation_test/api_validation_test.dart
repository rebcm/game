import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('API Validation Tests', () {
    testWidgets('Validate API response against contract', (tester) async {
      final response = await http.get(Uri.parse('https://api.example.com/endpoint'));
      expect(response.statusCode, 200);

      final jsonData = jsonDecode(response.body);
      expect(jsonData, isA<Map<String, dynamic>>());
      expect(jsonData['requiredKey'], isNotNull);
    });
  });
}
