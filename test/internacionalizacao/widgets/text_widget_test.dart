import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/text_widget.dart';

void main() {
  testWidgets('TextWidget não deve ter overflow', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextWidget('Uma string muito longa que pode causar overflow'),
        ),
      ),
    );

    expect(find.byType(OverflowError), findsNothing);
  });
}
