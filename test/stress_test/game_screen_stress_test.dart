import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:leak_tracker/leak_tracker.dart';

void main() {
  testWidgets('Game screen stress test', (tester) async {
    await LeakTracker.start();
    for (var i = 0; i < 10; i++) {
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Play'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
    }
    final leaks = await LeakTracker.stop();
    expect(leaks, isEmpty);
  });
}
