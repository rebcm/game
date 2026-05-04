import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Profile scene rebuilds during Undo/Redo', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final undoButtonFinder = find.byTooltip('Undo');
    final redoButtonFinder = find.byTooltip('Redo');

    expect(undoButtonFinder, findsOneWidget);
    expect(redoButtonFinder, findsOneWidget);

    await tester.tap(undoButtonFinder);
    await tester.pumpAndSettle();

    await tester.tap(redoButtonFinder);
    await tester.pumpAndSettle();
  });
}
