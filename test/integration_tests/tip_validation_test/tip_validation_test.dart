import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate tip UX', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final tipFinder = find.byValueKey('construction_tip');
    expect(tipFinder, findsOneWidget);
    expect(tester.widget<Text>(tipFinder).data, isNotEmpty);
  });
}
