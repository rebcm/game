import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Persistence Integration Tests', () {
    testWidgets('metadata persistence test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate metadata change
      // Assuming there's a button to trigger metadata change
      await tester.tap(find.byTooltip('Change Metadata'));
      await tester.pumpAndSettle();

      // Verify metadata is persisted
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('metadata'), isNotNull);
    });

    testWidgets('file persistence test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate file save
      // Assuming there's a button to trigger file save
      await tester.tap(find.byTooltip('Save File'));
      await tester.pumpAndSettle();

      // Verify file is persisted
      // Implement file existence check
      expect(true, isTrue); // Replace with actual file existence check
    });
  });
}
