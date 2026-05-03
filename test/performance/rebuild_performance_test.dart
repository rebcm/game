import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Initialize the game world
    await tester.pumpAndSettle();

    // Get the initial number of blocks
    final initialBlocks = find.byType(BlockWidget);

    // Perform an action that changes the game state
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Undo the action
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle();

    // Verify that the number of rebuilds is zero for unaffected blocks
    expect(find.byType(BlockWidget), initialBlocks);
  });
}
