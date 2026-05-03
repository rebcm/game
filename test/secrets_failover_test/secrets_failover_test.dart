import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Secrets Failover Tests', () {
    testWidgets('Build fails when secrets are missing', (tester) async {
      await dotenv.load(fileName: '.env.example'); // Load example env without secrets
      try {
        await app.main();
        fail('App started successfully without secrets');
      } catch (e) {
        expect(e.toString(), contains('Missing required environment variables'));
      }
    });

    testWidgets('Build fails when secrets are incorrect', (tester) async {
      await dotenv.load(fileName: '.env.invalid'); // Assume .env.invalid has incorrect secrets
      try {
        await app.main();
        fail('App started successfully with incorrect secrets');
      } catch (e) {
        expect(e.toString(), contains('Invalid environment variables'));
      }
    });
  });
}
