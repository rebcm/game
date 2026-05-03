import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/screens/help/help_screen.dart';

void main() {
  testWidgets('HelpScreen displays list of tips and FAB', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HelpScreen()));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Tapping FAB shows TipModal', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HelpScreen()));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(TipModal), findsOneWidget);
  });
}
