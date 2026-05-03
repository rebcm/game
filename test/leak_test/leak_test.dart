import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Rebeca App Leak Test', (tester) async {
    await LeakTracker.startTracking();
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    // Navigate through main screens
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    await LeakTracker.stopTracking();
    final leaks = await LeakTracker.getLeaks();
    expect(leaks, isEmpty);
  });
}
