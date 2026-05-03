import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('pseudo-localization integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify text wrapping/ellipsis behavior
    expect(find.text('Expanded text'), findsOneWidget);
    expect(find.byType(TextOverflow.ellipsis), findsOneWidget);
  });
}
