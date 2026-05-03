import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/performance_testing/widget_tracker.dart';
import 'package:game/main.dart' as game;

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(game.MyApp());

    // Wait for the game to load
    await tester.pumpAndSettle();

    // Track rebuilds
    final widgetTracker = WidgetTracker();
    widgetTracker.startTracking();

    // Perform an undo operation
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pump();

    // Verify that unaffected widgets were not rebuilt
    expect(widgetTracker.getRebuildCount('BlockWidget'), 0);

    widgetTracker.stopTracking();
  });
}
