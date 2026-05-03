import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:intl/intl.dart' as intl;

void main() {
  testWidgets('Dicas layout test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Test with different locales
    await tester.binding.setLocale(intl.Intl.defaultLocale = 'en_US');
    await tester.pumpAndSettle();
    expect(find.text('Tips'), findsOneWidget);

    await tester.binding.setLocale(intl.Intl.defaultLocale = 'pt_BR');
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);

    // Check for overflow
    await tester.binding.setLocale(intl.Intl.defaultLocale = 'fr_FR');
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
