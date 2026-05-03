import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Teste de RTL (Right-to-Left)', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale('ar'), // Árabe
        home: MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verificar se o layout está espelhado corretamente
    expect(find.text('Rebeca'), findsOneWidget);
    // Adicione mais verificações conforme necessário
  });
}
