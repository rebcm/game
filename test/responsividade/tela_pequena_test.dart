import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Testa responsividade em tela pequena', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.binding.setSurfaceSize(const Size(300, 600));

    await tester.pumpAndSettle();

    expect(find.text('Rebeca'), findsOneWidget);
  });
}
