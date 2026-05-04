import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Profile scene rebuilds during Undo/Redo operations', (tester) async {
    await tester.pumpWidget(MyApp());

    // Initialize the scene
    await tester.pumpAndSettle();

    // Perform Undo/Redo operations
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Redo'));
    await tester.pumpAndSettle();

    // Verify the number of rebuilds
    expect(tester.binding.hasWidgetListChanged, false);
  });
}
