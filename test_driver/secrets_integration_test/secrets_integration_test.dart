import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Secrets Integration Test', (tester) async {
    await dotenv.load();
    final envVars = dotenv.env;

    expect(envVars, isNotNull);
    expect(envVars['VARIABLE_NAME'], isNotNull); // Replace 'VARIABLE_NAME' with actual secret/variable name

    // Add more expectations for other secrets/variables as needed
  });
}
