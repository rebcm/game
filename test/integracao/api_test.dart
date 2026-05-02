import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/test/integracao/api_mock.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('API integration test', (tester) async {
    final mockClient = MockClient();
    ApiMock.setupMockClient(mockClient);

    app.main(client: mockClient);
    await tester.pumpAndSettle();

    // Implement test logic here
  });
}
