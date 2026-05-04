import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test data source switching', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify initial data source
    final initialSource = find.text('Default Source');
    expect(initialSource, findsOneWidget);

    // Switch data source
    await tester.tap(find.byIcon(Icons.swap_horiz));
    await tester.pumpAndSettle();

    // Verify switched data source
    final switchedSource = find.text('Alternative Source');
    expect(switchedSource, findsOneWidget);
  });
}
