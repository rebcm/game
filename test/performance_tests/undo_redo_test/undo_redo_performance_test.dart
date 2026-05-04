import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Undo/Redo performance test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Wait for the game to load
    await tester.pumpAndSettle();

    // Perform a series of actions (e.g., place blocks)
    for (int i = 0; i < 10; i++) {
      await tester.tap(find.byTooltip('Place Block'));
      await tester.pump();
    }

    // Measure rebuilds during Undo/Redo
    int initialRebuilds = tester.binding.renderViewElement?.debugRebuildCount ?? 0;

    await tester.tap(find.byTooltip('Undo'));
    await tester.pump();

    int undoRebuilds = tester.binding.renderViewElement?.debugRebuildCount ?? 0;
    expect(undoRebuilds - initialRebuilds, lessThan(5)); // Adjust threshold as needed

    await tester.tap(find.byTooltip('Redo'));
    await tester.pump();

    int redoRebuilds = tester.binding.renderViewElement?.debugRebuildCount ?? 0;
    expect(redoRebuilds - undoRebuilds, lessThan(5)); // Adjust threshold as needed
  });
}
