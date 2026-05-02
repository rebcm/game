import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('Checklist de Validação de Conteúdo', () {
    test('Arquivo existe', () {
      expect(File('assets/docs/checklists/validacao_conteudo.md').existsSync(), true);
    });

    test('Conteúdo básico presente', () {
      final conteudo = File('assets/docs/checklists/validacao_conteudo.md').readAsStringSync();
      expect(conteudo.contains('Checklist de Validação de Conteúdo'), true);
      expect(conteudo.contains('Descrição para Lojas de Aplicativos'), true);
      expect(conteudo.contains('Conteúdo do Jogo'), true);
      expect(conteudo.contains('SEO e Descoberta'), true);
      expect(conteudo.contains('Internacionalização'), true);
    });
  });
}
