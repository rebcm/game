import 'package:integration_test/integration_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration: Environment Variables Validation', () {
    testWidgets('should load .env file and start app', (tester) async {
      await dotenv.load();
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Game'), findsOneWidget);
    });
  });
}
