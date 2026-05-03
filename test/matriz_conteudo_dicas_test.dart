import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('Matriz de conteúdo de dicas existe', () {
    final matrizConteudoFile = File('docs/matriz_conteudo_dicas.json');
    expect(matrizConteudoFile.existsSync(), isTrue);
  });

  test('Matriz de conteúdo de dicas não está vazia', () {
    final matrizConteudoFile = File('docs/matriz_conteudo_dicas.json');
    final content = matrizConteudoFile.readAsStringSync();
    expect(content, isNotEmpty);
  });
}
