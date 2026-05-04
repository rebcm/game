import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate tip visibility and content', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final tipFinder = find.text('Dica: Construa sua estrutura aqui!');
    expect(tipFinder, findsOneWidget);

    final closeTipButton = find.byIcon(Icons.close);
    await tester.tap(closeTipButton);
    await tester.pumpAndSettle();

    expect(tipFinder, findsNothing);
  });

  testWidgets('Validate tip navigation', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final nextTipButton = find.text('Próxima Dica');
    await tester.tap(nextTipButton);
    await tester.pumpAndSettle();

    final tipContent = find.text('Dica: Use diferentes blocos para criar!');
    expect(tipContent, findsOneWidget);
  });
}
