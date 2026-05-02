import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('Validar Matriz de Retenção', () {
    test('Verifica existência do documento de matriz de retenção', () async {
      final response = await http.get(Uri.parse('https://raw.githubusercontent.com/rebcm/game/main/docs/especificacoes/matriz-retencao-artefatos.md'));
      expect(response.statusCode, 200, reason: 'O documento de matriz de retenção não foi encontrado');
    });

    test('Verifica conteúdo do documento de matriz de retenção', () async {
      final response = await http.get(Uri.parse('https://raw.githubusercontent.com/rebcm/game/main/docs/especificacoes/matriz-retencao-artefatos.md'));
      final content = response.body;
      expect(content.contains('## Critérios de Retenção'), isTrue, reason: 'O documento não contém a seção de critérios de retenção');
      expect(content.contains('### Artefatos de `branch/feature`'), isTrue, reason: 'O documento não contém a subseção de artefatos de branch/feature');
      expect(content.contains('### Artefatos de `release/stable`'), isTrue, reason: 'O documento não contém a subseção de artefatos de release/stable');
    });
  });
}
