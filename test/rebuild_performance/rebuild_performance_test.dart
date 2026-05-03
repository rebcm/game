import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game/game.dart';

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    final world = tester.state<WorldState>(find.byType(World));
    final initialChunk = world.chunkManager.chunks.values.first;

    // Modify a block
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Undo the modification
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle();

    // Verify that the unaffected blocks were not rebuilt
    expect(initialChunk.rebuildCount, 0);
  });
}
