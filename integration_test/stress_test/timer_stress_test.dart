import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Timer stress test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Jogar'));
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.text('Sair'));
      await tester.pumpAndSettle(Duration(seconds: 1));
    }
  });
}
