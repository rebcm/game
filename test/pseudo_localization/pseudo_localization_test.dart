import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Pseudo-localization test', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Simulate pseudo-localization by extending text
    await tester.binding.setLocale('pseudo', 'Pseudo');
    await tester.pumpAndSettle();

    // Verify that no text overflows occur
    expect(find.byType(OverflowError), findsNothing);
  });
}
