import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/animacao/repainter.dart';

void main() {
  testWidgets('Repainter should render child', (tester) async {
    await tester.pumpWidget(const Repainter(child: Text('Test')));
    expect(find.text('Test'), findsOneWidget);
  });
}
