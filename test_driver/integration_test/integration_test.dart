import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Smoke Test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(Duration(seconds: 5));
    expect(find.byType('flt-glass-pane'), findsOneWidget);
  });
}
