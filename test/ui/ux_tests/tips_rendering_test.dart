import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('Renderização de dicas em diferentes tamanhos de tela', (tester) async {
    await tester.pumpWidget(MyApp());

    await tester.binding.window.physicalSizeTestValue = Size(320, 480); // Small
    await tester.pumpAndSettle();
    expect(find.text('Dica'), findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(768, 1024); // Medium
    await tester.pumpAndSettle();
    expect(find.text('Dica'), findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(1920, 1080); // Large
    await tester.pumpAndSettle();
    expect(find.text('Dica'), findsOneWidget);
  });

  testWidgets('Comportamento de overflow de texto nas dicas', (tester) async {
    await tester.pumpWidget(MyApp());

    await tester.binding.window.physicalSizeTestValue = Size(320, 480); // Small
    await tester.pumpAndSettle();

    final textFinder = find.text('Dica muito longa que deve causar overflow');
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.overflow, TextOverflow.ellipsis);
  });
}
