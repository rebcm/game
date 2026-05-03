import 'package:flutter/material.dart';
import 'package:game/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgets('Stress test for game screen', (tester) async {
    await tester.runAsync(() async {
      for (int i = 0; i < 10; i++) {
        await tester.pumpWidget(MyApp());
        await tester.tap(find.text('Play'));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
      }
    });
    final leaks = await LeakTracker.getLeaks();
    expect(leaks, isEmpty);
  });
}
