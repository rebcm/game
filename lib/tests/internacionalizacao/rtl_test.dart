import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('RTL Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('ar'), // Arabic locale for RTL testing
        home: MyApp(),
      ),
    );

    // Add your RTL test logic here
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
