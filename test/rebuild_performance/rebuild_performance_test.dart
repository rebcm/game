import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game/game.dart';

void main() {
  testWidgets('Rebuild performance test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Initialize the game world
    await tester.pumpAndSettle();

    // Get the initial rebuild count
    int initialRebuildCount = rebuildCount;

    // Perform an Undo operation
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle();

    // Get the final rebuild count
    int finalRebuildCount = rebuildCount;

    // Assert that the rebuild count for unaffected widgets is zero
    expect(finalRebuildCount - initialRebuildCount, 0);
  });
}
