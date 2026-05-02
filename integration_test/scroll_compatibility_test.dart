import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Scroll Compatibility Test', () {
    testWidgets('scroll test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Perform scroll action
      await tester.drag(find.byType(ListView), Offset(0, -300));
      await tester.pumpAndSettle();

      // Verify scroll result
      expect(find.text('Scrolled'), findsOneWidget);
    });
  });
}
