import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/testes/integracao/upload/criterios_aceitacao.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verificar upload de arquivo', (tester) async {
    // Simular o upload do arquivo
    final urlArquivo = 'https://example.com/arquivo.txt';
    final idArquivo = '12345';
    final checksumEsperado = 'abcdef';

    await CriteriosAceitacaoUpload.verificarChecksumArquivo(urlArquivo, checksumEsperado);
    await CriteriosAceitacaoUpload.verificarStatusUploaded(idArquivo);
  });
}
