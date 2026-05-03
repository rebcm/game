import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/tip_wrapper/tip_wrapper.dart';

void main() {
  testWidgets('TipWrapper displays child', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: TipWrapper(child: Text('Test child')),
    ));

    expect(find.text('Test child'), findsOneWidget);
  });
}
