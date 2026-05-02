import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('API Integration Tests', () {
    testWidgets('validate API connection', (tester) async {
      final response = await http.get(Uri.parse('https://construcao-criativa.workers.dev'));
      expect(response.statusCode, 200);
    });

    testWidgets('validate chunk upload', (tester) async {
      final dio = Dio();
      final response = await dio.post('https://construcao-criativa.workers.dev/chunk');
      expect(response.statusCode, 200);
    });
  });
}
