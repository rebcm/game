import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Pseudo-localization test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simulate pseudo-localization by extending text
    await tester.binding.setLocaleForTesting(const Locale('pseudo'));

    await tester.pumpAndSettle();

    // Verify that there are no text overflows
    expect(find.byType(OverflowError), findsNothing);
  });
}
