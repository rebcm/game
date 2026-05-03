import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:game/features/dicas/integracao/integracao_dicas.dart';

void main() {
  testWidgets('deve mostrar ContextoDicas', (tester) async {
    await tester.pumpWidget(IntegracaoDicas(telaAtual: 'TelaInicial'));
    expect(find.byType(ContextoDicas), findsOneWidget);
  });
}
