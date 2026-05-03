import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Rebuild performance test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Perform an action that changes the state
    await tester.tap(find.byTooltip('Add Block'));
    await tester.pumpAndSettle();

    // Verify that the number of rebuilds is zero during an Undo operation
    final initialRebuildCount = tester.binding.renderViewElement?.debugRebuildCount ?? 0;
    await tester.tap(find.byTooltip('Undo'));
    await tester.pump();
    final finalRebuildCount = tester.binding.renderViewElement?.debugRebuildCount ?? 0;
    expect(finalRebuildCount - initialRebuildCount, 0);
  });
}
