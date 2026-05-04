import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as game;

void main() {
  testWidgets('Profile scene rebuilds during Undo/Redo operations', (tester) async {
    await tester.pumpWidget(game.MyApp());

    // Initialize the scene and perform some operations
    await tester.tap(find.text('Build Mode'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Start profiling
    final stopwatch = Stopwatch()..start();
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.redo));
    await tester.pumpAndSettle();
    stopwatch.stop();

    // Log or verify the rebuild count and time
    print('Time taken for Undo/Redo: ${stopwatch.elapsedMilliseconds} ms');
    // Add verification logic here
  });
}
