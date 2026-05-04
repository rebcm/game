import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Multitouch Edge Cases Test', () {
    testWidgets('Test saturated multitouch input (>10 points)', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate multitouch input with more than 10 points
      final TestGesture gesture1 = await tester.createGesture();
      final TestGesture gesture2 = await tester.createGesture();
      final TestGesture gesture3 = await tester.createGesture();
      final TestGesture gesture4 = await tester.createGesture();
      final TestGesture gesture5 = await tester.createGesture();
      final TestGesture gesture6 = await tester.createGesture();
      final TestGesture gesture7 = await tester.createGesture();
      final TestGesture gesture8 = await tester.createGesture();
      final TestGesture gesture9 = await tester.createGesture();
      final TestGesture gesture10 = await tester.createGesture();
      final TestGesture gesture11 = await tester.createGesture();

      await gesture1.down(tester.getCenter(find.byType(InteractiveViewer)));
      await gesture2.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(10, 10));
      await gesture3.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(20, 20));
      await gesture4.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(30, 30));
      await gesture5.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(40, 40));
      await gesture6.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(50, 50));
      await gesture7.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(60, 60));
      await gesture8.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(70, 70));
      await gesture9.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(80, 80));
      await gesture10.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(90, 90));
      await gesture11.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(100, 100));

      await tester.pumpAndSettle();

      // Verify that the app doesn't crash
      expect(find.byType(InteractiveViewer), findsOneWidget);

      await gesture1.up();
      await gesture2.up();
      await gesture3.up();
      await gesture4.up();
      await gesture5.up();
      await gesture6.up();
      await gesture7.up();
      await gesture8.up();
      await gesture9.up();
      await gesture10.up();
      await gesture11.up();

      await tester.pumpAndSettle();
    });

    testWidgets('Test abrupt signal interruption during combined commands', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate multitouch input
      final TestGesture gesture1 = await tester.createGesture();
      final TestGesture gesture2 = await tester.createGesture();

      await gesture1.down(tester.getCenter(find.byType(InteractiveViewer)));
      await gesture2.down(tester.getCenter(find.byType(InteractiveViewer)) + Offset(10, 10));

      await tester.pump();

      // Simulate abrupt signal interruption
      await gesture1.cancel();
      await gesture2.cancel();

      await tester.pumpAndSettle();

      // Verify that the app doesn't crash
      expect(find.byType(InteractiveViewer), findsOneWidget);
    });
  });
}
