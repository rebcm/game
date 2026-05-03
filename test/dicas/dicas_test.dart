import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/dicas/dicas.dart';

void main() {
  testWidgets('Dicas widget should wrap text correctly for long strings', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Dicas(
            dica: 'a' * 1000,
          ),
        ),
      ),
    );

    expect(find.text('a' * 1000), findsOneWidget);
    expect(tester.getSize(find.text('a' * 1000)).height, greaterThan(20));
  });

  testWidgets('Dicas widget should handle different languages', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Dicas(
                dica: 'Olá, mundo!',
              ),
              Dicas(
                dica: 'Hello, world!',
              ),
              Dicas(
                dica: 'Bonjour, monde!',
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Olá, mundo!'), findsOneWidget);
    expect(find.text('Hello, world!'), findsOneWidget);
    expect(find.text('Bonjour, monde!'), findsOneWidget);
  });
}
