import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Multitouch Edge Cases Test', () {
    testWidgets('Test multiple touch points (>10)', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final gesture = await tester.createGesture();
      await gesture.down(tester.getCenter(find.byType(Scrollable)));
      await tester.pump();

      for (int i = 0; i < 15; i++) {
        final Offset offset = Offset(50 + i * 10, 50 + i * 10);
        await tester.tapAt(offset);
        await tester.pump(const Duration(milliseconds: 50));
      }

      await tester.pumpAndSettle();
      expect(find.text('Rebeca'), findsOneWidget);
    });

    testWidgets('Test abrupt signal interruption during combined commands', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final gesture = await tester.createGesture();
      await gesture.down(tester.getCenter(find.byType(Scrollable)));
      await tester.pump();

      await tester.tapAt(Offset(50, 50));
      await tester.pump(const Duration(milliseconds: 50));

      await gesture.up();
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsOneWidget);
    });
  });
}
