import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('documentacao_test', (tester) async {
    final documentacaoFile = File('docs/documentacao/conteudo_documentacao.md');
    final documentacaoExists = await documentacaoFile.exists();
    expect(documentacaoExists, true, reason: 'Documentação não encontrada');
  });
}
