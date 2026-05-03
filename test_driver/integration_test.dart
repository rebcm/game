import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implement your test logic here
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
