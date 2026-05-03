import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('documentacao teste', (tester) async {
    final documentacaoFile = File('docs/bloco_documentation.json');
    final documentacaoExists = await documentacaoFile.exists();
    expect(documentacaoExists, true);

    final documentacaoContent = await documentacaoFile.readAsString();
    expect(documentacaoContent, isNotEmpty);
  });
}
