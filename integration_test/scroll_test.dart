import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Scroll Test', () {
    testWidgets('scrolling test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find the scrollable widget
      final scrollable = find.byType(Scrollable);
      expect(scrollable, findsOneWidget);

      // Perform scroll gesture
      await tester.drag(scrollable, Offset(0, -300));
      await tester.pumpAndSettle();

      // Verify scroll position
      expect(find.text('Block Type: Grass'), findsWidgets);
    });
  });
}
