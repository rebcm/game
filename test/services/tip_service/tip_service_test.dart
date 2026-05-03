import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/tip_service/tip_service.dart';

void main() {
  testWidgets('TipService shows tip', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) {
          TipService().showTip(context, 'Test tip');
          return const Scaffold(body: Text('Test'));
        },
      ),
    ));

    await tester.pump();

    expect(find.text('Test tip'), findsOneWidget);
  });
}
