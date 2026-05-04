import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Widget test runner', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Rebeca'),
        ),
      ),
    ));

    expect(find.text('Rebeca'), findsOneWidget);
  });
}
