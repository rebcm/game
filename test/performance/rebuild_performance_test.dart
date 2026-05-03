import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/performance_testing/widget_tracker.dart';
import 'package:game/main.dart' as game;

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(game.MyApp());
    await tester.pumpAndSettle();

    final widgetTracker = WidgetTracker();
    await widgetTracker.init();

    // Perform some actions to populate the world
    await tester.tap(find.text('Build'));
    await tester.pumpAndSettle();

    // Track rebuilds
    await widgetTracker.startTracking();

    // Perform an Undo operation
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    // Stop tracking rebuilds
    final rebuildCount = await widgetTracker.stopTracking();

    // Verify that the number of rebuilds is zero for unaffected widgets
    expect(rebuildCount, 0);
  });
}
