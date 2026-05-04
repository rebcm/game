import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate tips are displayed during gameplay', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final tipFinder = find.text('Dica: Construa usando diferentes blocos');
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(tipFinder, findsOneWidget);

    await tester.tap(find.byIcon(Icons.build));
    await tester.pumpAndSettle();

    expect(tipFinder, findsNothing);
  });

  testWidgets('Validate tips change after certain interval', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final initialTip = find.text('Dica: Construa usando diferentes blocos');
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(initialTip, findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 10));
    final changedTip = find.text('Dica: Experimente mudar a cor dos blocos');
    expect(changedTip, findsOneWidget);
  });
}
