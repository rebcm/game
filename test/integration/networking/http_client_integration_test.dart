import 'package:integration_test/integration_test.dart';
import 'package:game/networking/http_client.dart';
import 'package:game/networking/http_client_factory.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('http client integration test', (tester) async {
    final client = HttpClientFactory.createHttpClient();
    final response = await client.get(Uri.parse('https://example.com'));

    expect(response.statusCode, 200);
  });
}
