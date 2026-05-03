import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/widgets/dicas_construcao.dart';

void main() {
  testWidgets('Dicas de construção são renderizadas corretamente', (tester) async {
    await tester.pumpWidget(app.RebecaApp());
    await tester.pumpAndSettle();

    expect(find.byType(DicasConstrucao), findsOneWidget);
    expect(find.text('Dicas de Construção'), findsOneWidget);
  });

  testWidgets('Navegação até o conteúdo das dicas', (tester) async {
    await tester.pumpWidget(app.RebecaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Dicas de Construção'));
    await tester.pumpAndSettle();

    expect(find.text('Conteúdo das Dicas'), findsOneWidget);
  });

  testWidgets('Dicas de construção são responsivas', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    await tester.pumpWidget(app.RebecaApp());
    await tester.pumpAndSettle();

    expect(find.byType(DicasConstrucao), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(480, 800));
    await tester.pumpAndSettle();

    expect(find.byType(DicasConstrucao), findsOneWidget);
  });
}
