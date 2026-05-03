import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Validação de responsividade em telas pequenas', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.binding.setSurfaceSize(const Size(320, 480));
    await tester.pumpAndSettle();

    expect(find.text('Rebeca'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('Verifica truncamento de dicas em telas pequenas', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.binding.setSurfaceSize(const Size(280, 480));
    await tester.pumpAndSettle();

    expect(find.text('Rebeca'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}
