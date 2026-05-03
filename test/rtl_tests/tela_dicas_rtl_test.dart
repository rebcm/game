import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Tela de dicas RTL test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('ar'), // Arabic locale for RTL test
        home: DicasTela(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify layout and text rendering
    expect(find.text('دicas'), findsOneWidget); // Example RTL text
    expect(find.byType(GridView), findsOneWidget);
  });
}
