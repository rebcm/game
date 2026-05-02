import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('persistência de metadados e arquivos', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a criação de um novo projeto
    await tester.tap(find.text('Novo Projeto'));
    await tester.pumpAndSettle();

    // Verifica se o projeto foi criado com sucesso
    expect(find.text('Projeto Criado'), findsOneWidget);

    // Simula a edição do projeto
    await tester.tap(find.text('Editar Projeto'));
    await tester.pumpAndSettle();

    // Verifica se as alterações foram salvas corretamente
    expect(find.text('Alterações Salvas'), findsOneWidget);

    // Simula a saída do aplicativo
    await tester.tap(find.text('Sair'));
    await tester.pumpAndSettle();

    // Reinicia o aplicativo
    app.main();
    await tester.pumpAndSettle();

    // Verifica se as alterações persistem após a reinicialização
    expect(find.text('Alterações Salvas'), findsOneWidget);
  });
}
