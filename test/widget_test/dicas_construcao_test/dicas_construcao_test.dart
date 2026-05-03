import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/widgets/dicas_construcao.dart';

void main() {
  testWidgets('Dicas de Construção UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(app.RebecaApp());

    await tester.tap(find.text('Dicas de Construção'));
    await tester.pumpAndSettle();

    expect(find.byType(DicasConstrucao), findsOneWidget);
  });

  testWidgets('Dicas de Construção Navegabilidade Test', (WidgetTester tester) async {
    await tester.pumpWidget(app.RebecaApp());

    await tester.tap(find.text('Dicas de Construção'));
    await tester.pumpAndSettle();

    expect(find.text('Dica 1'), findsOneWidget);
    await tester.tap(find.text('Próxima'));
    await tester.pumpAndSettle();
    expect(find.text('Dica 2'), findsOneWidget);
  });

  testWidgets('Dicas de Construção Resolução Test', (WidgetTester tester) async {
    await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    await tester.pumpWidget(app.RebecaApp());

    await tester.tap(find.text('Dicas de Construção'));
    await tester.pumpAndSettle();

    expect(find.byType(DicasConstrucao), findsOneWidget);
  });
}
