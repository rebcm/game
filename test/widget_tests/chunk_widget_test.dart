import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/chunk_widget.dart';

void main() {
  testWidgets('ChunkWidget rebuild test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            ChunkWidget(chunkId: '1'),
            ChunkWidget(chunkId: '2'),
          ],
        ),
      ),
    );

    final initialBuildCount1 = find.text('Chunk 1');
    final initialBuildCount2 = find.text('Chunk 2');

    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            ChunkWidget(chunkId: '1'),
            ChunkWidget(chunkId: '3'), // Change chunkId to trigger rebuild
          ],
        ),
      ),
    );

    final afterRebuildCount1 = find.text('Chunk 1');
    final afterRebuildCount2 = find.text('Chunk 2');
    final afterRebuildCount3 = find.text('Chunk 3');

    expect(initialBuildCount1, findsOneWidget);
    expect(initialBuildCount2, findsOneWidget);
    expect(afterRebuildCount1, findsOneWidget); // Should not rebuild
    expect(afterRebuildCount2, findsNothing); // Should be removed
    expect(afterRebuildCount3, findsOneWidget); // Should be new
  });
}
