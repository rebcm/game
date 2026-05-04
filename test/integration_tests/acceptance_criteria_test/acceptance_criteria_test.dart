import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verify acceptance criteria for task-1777666324-13-sub-4-disc-1777777728-2-disc-1777908606-4', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Rebeca'), findsOneWidget);
  });
}
