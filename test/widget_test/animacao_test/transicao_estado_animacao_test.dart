import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/animacao.dart';

void main() {
  testWidgets('transição entre estados de animação', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Animacao()));
    await tester.pumpAndSettle();
    expect(find.byType(Animacao), findsOneWidget);
  });
}
