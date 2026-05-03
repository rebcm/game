import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Teste de RTL (Right-to-Left)', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('ar'), 
        home: MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Rebeca'), findsOneWidget);

  });
}
