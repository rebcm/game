import 'package:integration_test/integration_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Secrets Fail Safe Test', () {
    testWidgets('should stop build when signature secret is missing', (tester) async {
      await dotenv.load(fileName: '.env.example');
      dotenv.env.remove('SIGNATURE_SECRET');
      expect(() async {
        await app.main();
      }, throwsAssertionError);
    });

    testWidgets('should stop build when signature secret is malformed', (tester) async {
      await dotenv.load(fileName: '.env.example');
      dotenv.env['SIGNATURE_SECRET'] = 'invalid_secret';
      expect(() async {
        await app.main();
      }, throwsAssertionError);
    });
  });
}
