import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Testa overflow de texto em idiomas longos', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('de', 'DE'), // Alemão
        home: Scaffold(
          body: app.MyHomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TextOverflow), findsNothing);

    await tester.binding.window.localeTestProperty(Locale('fr', 'FR')); // Francês
    await tester.pumpAndSettle();

    expect(find.byType(TextOverflow), findsNothing);
  });
}
