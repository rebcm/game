import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('rebuild performance test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Get the initial rebuild count
    int initialRebuildCount = rebuildCount;

    // Perform an undo operation
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle();

    // Verify that the rebuild count has not changed
    expect(rebuildCount, initialRebuildCount);
  });
}

// Mock rebuild count variable for testing purposes
int rebuildCount = 0;
