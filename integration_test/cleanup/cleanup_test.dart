import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cleanup test', (tester) async {
    await tester.pumpAndSettle();

    final response = await http.delete(Uri.parse('https://example.com/cleanup'));
    expect(response.statusCode, 200);
  });
}
