import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('widget test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Text(
            'Pseudo-localization test',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    expect(find.text('Pseudo-localization test'), findsOneWidget);
  });
}
