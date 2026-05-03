import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/dicas.dart';

void main() {
  testWidgets('Dicas widget test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Dicas()));

    final dicasFinder = find.byValueKey('dicas');
    expect(dicasFinder, findsOneWidget);

    final proximaDicaFinder = find.byValueKey('proximaDica');
    expect(proximaDicaFinder, findsOneWidget);

    final primeiraDica = tester.widget<Text>(dicasFinder).data;
    await tester.tap(proximaDicaFinder);
    await tester.pump();

    final segundaDica = tester.widget<Text>(dicasFinder).data;
    expect(segundaDica, isNot(primeiraDica));
  });
}
