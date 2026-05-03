import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/dicas/dicas_integracao.dart';
import 'package:game/ui/navegacao/navegacao.dart';

void main() {
  testWidgets('Verifica integração da UI com dicas', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Navegacao()));
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    await tester.tap(find.text('Configurações'));
    await tester.pump();
    expect(find.text('Navegação para 1'), findsOnce);
  });
}
