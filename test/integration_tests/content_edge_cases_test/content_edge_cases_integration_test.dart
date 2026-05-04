import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/services/content_loader.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Content Edge Cases Integration Test', () {
    testWidgets('Test API timeout integration', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate API timeout
      expect(ContentLoader.loadFromAPI(timeout: Duration(seconds: 1)), throwsException);
    });

    testWidgets('Test missing local files integration', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate missing local file
      expect(ContentLoader.loadFromLocalFile('non_existent_file.json'), throwsException);
    });

    testWidgets('Test invalid JSON parsing integration', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate invalid JSON
      expect(ContentLoader.parseJSON('invalid_json'), throwsException);
    });
  });
}
