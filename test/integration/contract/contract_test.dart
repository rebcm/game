import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Contract test for API', (tester) async {
    final response = await http.get(Uri.parse('https://example.com/api/endpoint'));
    expect(response.statusCode, 200);
  });
}
