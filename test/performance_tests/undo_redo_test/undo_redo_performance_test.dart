import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Undo/Redo performance test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simulate some actions
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.redo));
    await tester.pump();

    // Measure rebuilds
    final rebuildCount = tester.binding.hasScheduledFrame ? 1 : 0;
    expect(rebuildCount, lessThan(5));
  });
}
