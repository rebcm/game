import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Stress test for timers', (tester) async {
    await tester.pumpWidget(MyApp());

    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Jogar'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sair'));
      await tester.pumpAndSettle();
    }
  });
}
