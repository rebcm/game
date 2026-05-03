import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Counter increments smoke test', (tester) async {
    await LeakTracker.startTracking();
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    final navigator = tester.widget<Navigator>(find.byType(Navigator));
    final navigatorKey = navigator.key as GlobalKey<NavigatorState>;

    await tester.tap(find.text('Next Screen'));
    await tester.pumpAndSettle();

    navigatorKey.currentState!.pop();
    await tester.pumpAndSettle();

    await LeakTracker.stopTracking();
    final leaks = await LeakTracker.getLeaks();
    expect(leaks, isEmpty);
  });
}
