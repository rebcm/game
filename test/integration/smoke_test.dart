import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('smoke test', (tester) async {
    await tester.pumpAndSettle();
    final response = await http.get(Uri.parse('https://example.com'));
    expect(response.statusCode, 200);
    // Save the result to a file
    await http.get(Uri.parse('https://example.com'));
  });
}
