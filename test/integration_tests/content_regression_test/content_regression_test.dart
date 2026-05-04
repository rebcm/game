import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Content Regression Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final localizedStrings = [
      'title',
      'welcome_message',
      // Add more localized strings as needed
    ];

    for (final key in localizedStrings) {
      expect(find.text(key), findsOneWidget);
    }

    // Add more test logic as needed
  });
}
