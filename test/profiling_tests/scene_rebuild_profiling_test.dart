import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Profile scene rebuilds during Undo/Redo', (tester) async {
    await tester.pumpWidget(MyApp());

    // Perform some actions to setup the scene
    await tester.pumpAndSettle();

    // Start profiling
    final stopwatch = Stopwatch()..start();
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    print('Undo took ${stopwatch.elapsedMilliseconds}ms');

    stopwatch.reset();
    await tester.tap(find.text('Redo'));
    await tester.pumpAndSettle();
    print('Redo took ${stopwatch.elapsedMilliseconds}ms');

    // Verify rebuild count
    final rebuildCount = tester.binding.debugWidgetBuildCount;
    print('Rebuild count: $rebuildCount');
    expect(rebuildCount, lessThan(100)); // Adjust the threshold as needed
  });
}
