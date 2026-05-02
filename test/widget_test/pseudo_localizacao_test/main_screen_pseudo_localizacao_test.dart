import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('Pseudo-localização não causa quebras de layout', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Simula pseudo-localização
    await tester.binding.setLocale('pseudo');

    await tester.pumpAndSettle();

    // Verifica se o layout não está quebrado
    expect(find.text('Rebeca'), findsOneWidget);
    expect(find.text('Criar'), findsOneWidget);
    expect(find.text('Configurações'), findsOneWidget);
  });
}
