import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('External Interruptions Test', () {
    testWidgets('Test interruption by phone call', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate phone call interruption
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Game'), findsOneWidget);
    });

    testWidgets('Test interruption by alarm', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate alarm interruption
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Game'), findsOneWidget);
    });

    testWidgets('Test interruption by system notification', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate system notification interruption
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();
      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Game'), findsOneWidget);
    });
  });
}
