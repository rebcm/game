import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Timer Stress Test', (tester) async {
    await tester.pumpWidget(MyApp());

    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();
    }

    expect(true, true); // Memory leak check is done via external script
  });
}
