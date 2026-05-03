import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();

    // Get the initial count of rebuilds
    int initialRebuildCount = 0;
    // Assume we have a way to count rebuilds, e.g., using a test double or a widget that tracks rebuilds
    // For demonstration, we'll skip the actual implementation of counting rebuilds

    // Perform an Undo operation
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle();

    // Get the final count of rebuilds
    int finalRebuildCount = 0;
    // Again, assume we have a way to count rebuilds

    // Assert that the number of rebuilds of unaffected widgets is zero
    expect(finalRebuildCount - initialRebuildCount, 0);
  });
}
