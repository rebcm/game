import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('input stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final rebeca = find.byType(Rebeca);
    expect(rebeca, findsOneWidget);

    final initialPosition = tester.getCenter(rebeca);

    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump(const Duration(milliseconds: 16));
    await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowRight);

    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pump(const Duration(milliseconds: 16));
    await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowLeft);

    final finalPosition = tester.getCenter(rebeca);

    expect(initialPosition.dx, isNot(finalPosition.dx));
  });
}
