import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate secrets', (tester) async {
    await dotenv.load();
    final envVars = dotenv.env;

    expect(envVars, isNotNull);
    expect(envVars!['VARIABLE_NAME'], isNotEmpty);
    // Add more expectations for other secrets and environment variables
  });
}
