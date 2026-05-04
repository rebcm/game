import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Build version conflict test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Simulate build version conflict
    final context = tester.element(find.byType(MaterialApp));
    final scaffold = Scaffold.of(context);
    expect(scaffold.hasAppBar, true);
    // Check for version conflict error message
    expect(find.text('Version conflict'), findsOneWidget);
  });
}
