import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('Checklist de Validação de Documentação', () {
    test('should contain required topics', () async {
      final dicasFile = File('docs/dicas.md');
      final content = await dicasFile.readAsString();

      final requiredTopics = ["Versão do Flutter", "Dependências", "Variáveis de Ambiente", "Comandos de Build"];
      for (final topic in requiredTopics) {
        expect(content, contains(topic));
      }
    });
  });
}
