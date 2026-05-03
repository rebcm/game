import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('External Interruptions Test', () {
    testWidgets('pause and resume test', (tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();

      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsOneWidget);
    });

    testWidgets('inactive and resumed test', (tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await tester.pumpAndSettle();

      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsOneWidget);
    });

    testWidgets('detached test', (tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.detached);
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsNothing);
    });
  });
}
