import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/performance_testing/widget_tracker_impl.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();

    final widgetTracker = WidgetTrackerImpl();
    await widgetTracker.init();

    // Perform some actions to trigger Undo operation
    await tester.tap(find.text('Some Button')); // Replace with actual button to trigger Undo
    await tester.pumpAndSettle();

    final rebuildCount = await widgetTracker.getRebuildCount();
    expect(rebuildCount, 0);
  });
}
