import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Validate text overflow in German and French', (tester) async {
    await tester.pumpWidget(MyApp(locale: Locale('de', 'DE')));
    await tester.pumpAndSettle();

    expect(find.byType(TextOverflow), findsNothing);

    await tester.pumpWidget(MyApp(locale: Locale('fr', 'FR')));
    await tester.pumpAndSettle();

    expect(find.byType(TextOverflow), findsNothing);
  });
}
