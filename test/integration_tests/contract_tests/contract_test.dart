import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'helpers/test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Contract test for frontend changes', (tester) async {
    final response = await makeGetRequest('http://localhost:8080/api/endpoint');
    expect(response.statusCode, 200);
  });
}
