import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:game/features/dicas/contexto/contexto_dicas.dart';

void main() {
  testWidgets('deve mostrar dica para TelaInicial', (tester) async {
    await tester.pumpWidget(ContextoDicas(telaAtual: 'TelaInicial'));
    expect(find.byType(Tooltip), findsOneWidget);
  });

  testWidgets('deve mostrar dica para TelaConstrucao', (tester) async {
    await tester.pumpWidget(ContextoDicas(telaAtual: 'TelaConstrucao'));
    expect(find.byType(Modal), findsOneWidget);
  });

  testWidgets('não deve mostrar dica para outras telas', (tester) async {
    await tester.pumpWidget(ContextoDicas(telaAtual: 'TelaOutros'));
    expect(find.byType(Container), findsOneWidget);
  });
}
