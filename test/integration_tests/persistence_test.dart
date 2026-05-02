import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Persistence Test', () {
    testWidgets('Metadata and files persistence', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Simulate some action that triggers metadata and file persistence
      // For example, creating a new block or saving a project

      // Verify that the metadata and files are persisted correctly
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('some_metadata_key'), isNotNull);

      // Add more expectations as needed
    });
  });
}
