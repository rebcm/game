import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final Finder rebuildIndicator = find.text('Rebuild Count: 0');
    expect(rebuildIndicator, findsOneWidget);

    // Simulate some action that should trigger a rebuild
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Check if the rebuild count has changed
    expect(find.text('Rebuild Count: 0'), findsNothing);
    expect(find.text('Rebuild Count: 1'), findsOneWidget);
  });
}
