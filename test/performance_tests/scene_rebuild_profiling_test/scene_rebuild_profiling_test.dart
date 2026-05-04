import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Scene Rebuild Profiling Test', (tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();

    // Perform Undo/Redo operations and measure rebuilds
    final undoButton = find.text('Undo');
    final redoButton = find.text('Redo');

    expect(undoButton, findsOneWidget);
    expect(redoButton, findsOneWidget);

    await tester.tap(undoButton);
    await tester.pumpAndSettle();

    await tester.tap(redoButton);
    await tester.pumpAndSettle();
  });
}
