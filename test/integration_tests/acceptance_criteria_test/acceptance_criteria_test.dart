import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de Inicialização', (tester) async {
    // Implementação do teste de inicialização
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });

  testWidgets('Teste de Renderização', (tester) async {
    // Implementação do teste de renderização
    await tester.pumpAndSettle();
    expect(find.byType(VoxelBlock), findsWidgets);
  });

  testWidgets('Teste de Interação', (tester) async {
    // Implementação do teste de interação
    await tester.pumpAndSettle();
    await tester.tap(find.byType(VoxelBlock));
    expect(find.text('Rebeca interagiu com o bloco'), findsOneWidget);
  });
}

