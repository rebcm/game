import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/self_healing_test/self_healing_test.dart';

void main() {
  testWidgets('retoma execução após resolução manual de limite de armazenamento', (tester) async {
    await tester.pumpWidget(const SelfHealingTest());
    await tester.tap(find.text('Simular Limite de Armazenamento'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Resolver Limite de Armazenamento'));
    await tester.pumpAndSettle();
    expect(find.text('Execução retomada com sucesso'), findsOneWidget);
  });
}
