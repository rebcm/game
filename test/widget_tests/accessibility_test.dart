import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Testa acessibilidade com texto extra grande', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simula as configurações de acessibilidade com texto extra grande
    await tester.binding.window.textScaleFactorTestOverride = 2.5;

    await tester.pumpAndSettle();

    // Verifica se o conteúdo permanece visível e legível
    expect(find.text('Rebeca'), findsOneWidget);
    expect(find.text('Construção Criativa'), findsOneWidget);

    // Verifica se os elementos importantes são visíveis
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
