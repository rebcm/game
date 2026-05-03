import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Initialize the world
    await tester.pumpAndSettle();

    // Get the initial number of blocks
    final initialBlocks = find.byType(BlockWidget);

    // Perform an action that changes the world
    await tester.tap(find.byType(AddBlockButton));
    await tester.pumpAndSettle();

    // Undo the action
    await tester.tap(find.byType(UndoButton));
    await tester.pumpAndSettle();

    // Verify that the number of rebuilds is zero for unaffected blocks
    expect(find.byType(BlockWidget), initialBlocks);
  });
}
