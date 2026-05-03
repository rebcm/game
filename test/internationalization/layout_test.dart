import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Layout should adapt to different languages', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simulate different locales
    await tester.binding.setLocale('en');
    await tester.pumpAndSettle();
    expect(find.text('English text'), findsOneWidget);

    await tester.binding.setLocale('pt');
    await tester.pumpAndSettle();
    expect(find.text('Texto em português'), findsOneWidget);

    // Check for overflow
    await tester.binding.setLocale('fr'); // French has longer text
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
