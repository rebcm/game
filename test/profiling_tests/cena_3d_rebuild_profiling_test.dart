import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  testWidgets('Cena 3D Rebuild Profiling', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    final cena3dFinder = find.byType(Cena3D);
    expect(cena3dFinder, findsOneWidget);

    final cena3dWidget = tester.widget<Cena3D>(cena3dFinder);

    // Perform Undo/Redo operations
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Redo'));
    await tester.pumpAndSettle();

    // Use Flutter DevTools or similar to profile rebuilds
    // For this example, we'll just check if the Cena3D widget was rebuilt
    final cena3dRebuildCount = cena3dWidget.rebuildCount;
    expect(cena3dRebuildCount, lessThan(5)); // Adjust the expected value as needed
  });
}
