import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Text overflow widget test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Text('a' * 1000),
        ),
      ),
    );

    expect(find.text('a' * 1000), findsOneWidget);
  });
}
