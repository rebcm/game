import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('validar conteúdo da matriz de retenção', () {
    final file = File('docs/artefatos/matriz-retencao.md');
    expect(file.existsSync(), isTrue);
    final content = file.readAsStringSync();
    expect(content.contains('## Critérios de Retenção'), isTrue);
    expect(content.contains('### Artefatos de \'branch/feature\''), isTrue);
    expect(content.contains('### Artefatos de \'release/stable\''), isTrue);
  });
}

