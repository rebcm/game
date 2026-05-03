import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart'; // Assuming the main game widget is here

void main() {
  testWidgets('Rebuild performance test for Undo/Redo', (tester) async {
    await tester.pumpWidget(MyGameApp()); // Replace MyGameApp with the actual widget

    // Perform initial setup if necessary
    await tester.pumpAndSettle();

    // Initial rebuild count
    int initialRebuildCount = RebuildTracker.instance.rebuildCount;

    // Simulate Undo/Redo operations
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.redo));
    await tester.pumpAndSettle();

    // Final rebuild count
    int finalRebuildCount = RebuildTracker.instance.rebuildCount;

    // Compare rebuild counts
    expect(finalRebuildCount - initialRebuildCount, lessThan(5)); // Adjust the threshold as needed
  });
}

class RebuildTracker extends StatefulWidget {
  static RebuildTracker instance = RebuildTracker._();

  RebuildTracker._();

  @override
  _RebuildTrackerState createState() => _RebuildTrackerState();
}

class _RebuildTrackerState extends State<RebuildTracker> {
  int rebuildCount = 0;

  @override
  Widget build(BuildContext context) {
    rebuildCount++;
    RebuildTracker.instance.rebuildCount = rebuildCount;
    return Container(); // This widget should be part of the widget tree
  }
}
