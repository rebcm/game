import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test tips trigger during gameplay', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate gameplay actions and verify tips triggers
    await tester.tap(find.byKey(Key('build_button')));
    await tester.pumpAndSettle();
    expect(find.text('Build Tip'), findsOneWidget);

    await tester.tap(find.byKey(Key('destroy_button')));
    await tester.pumpAndSettle();
    expect(find.text('Destroy Tip'), findsOneWidget);
  });
}
