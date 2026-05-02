import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Stress test for chunk upload', (tester) async {
    final chunkData = List.generate(100, (index) => {'chunk': 'data$index'});
    final response = await http.post(
      Uri.parse('https://construcao-criativa.workers.dev/upload'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(chunkData),
    );
    expect(response.statusCode, 200);
  });

  testWidgets('Stress test for large file upload', (tester) async {
    final largeData = List.generate(10000, (index) => {'chunk': 'data$index'});
    final response = await http.post(
      Uri.parse('https://construcao-criativa.workers.dev/upload'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(largeData),
    );
    expect(response.statusCode, 200);
  });
}
