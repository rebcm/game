import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Detect text overflow', (tester) async {
    await tester.pumpWidget(MyApp());

    final textFinder = find.text('Rebeca');
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textFinder);
    final textSize = tester.getSize(textFinder);

    await tester.binding.setSurfaceSize(Size(100, 100));
    await tester.pumpAndSettle();

    final textSizeAfterResize = tester.getSize(textFinder);
    expect(textSizeAfterResize, lessThan(textSize));
  });
}
