import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/text_widget.dart';

void main() {
  testWidgets('Text widget overflow test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            width: 100,
            child: TextWidget('This is a very long text that should overflow'),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isFlutterError);
  });

  testWidgets('Text widget no overflow test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            width: 500,
            child: TextWidget('This is a very long text that should not overflow'),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
