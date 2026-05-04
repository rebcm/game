import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate Cloudflare Worker Secrets', (tester) async {
    final response = await http.get(Uri.parse('https://example.workers.dev/healthcheck'));
    expect(response.statusCode, 200);
    expect(response.body, 'OK');
  });
}
