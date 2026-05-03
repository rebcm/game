import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/utils/performance_testing/performance_tester.dart';

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final performanceTester = PerformanceTester(tester);
    await performanceTester.init();

    // Perform some actions to setup the test
    await tester.tap(find.text('Some Button'));
    await tester.pumpAndSettle();

    // Start measuring rebuilds
    performanceTester.startMeasuringRebuilds();

    // Perform an Undo operation
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    // Stop measuring rebuilds
    final rebuildCount = await performanceTester.stopMeasuringRebuilds();

    // Verify that the number of rebuilds is zero for unaffected widgets
    expect(rebuildCount, 0);
  });
}
