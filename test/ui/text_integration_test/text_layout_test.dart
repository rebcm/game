import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Text description fits in different screen sizes', (tester) async {
    await tester.pumpWidget(MyApp());

    final textFinder = find.text('Descrição detalhada do jogo');
    expect(textFinder, findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    await tester.pump();
    expect(tester.getSize(textFinder), isNot(Size.zero));

    await tester.binding.window.physicalSizeTestValue = Size(480, 800);
    await tester.pump();
    expect(tester.getSize(textFinder), isNot(Size.zero));

    await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    await tester.pump();
    expect(tester.getSize(textFinder), isNot(Size.zero));
  });
}
