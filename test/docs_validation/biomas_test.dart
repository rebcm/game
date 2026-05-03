import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('Testa se a documentação dos biomas existe', () {
    final file = File('./docs/biomas/descrição_dos_biomas.md');
    expect(file.existsSync(), isTrue);
  });

  test('Testa se a documentação dos biomas contém o título correto', () {
    final file = File('./docs/biomas/descrição_dos_biomas.md');
    final content = file.readAsStringSync();
    expect(content.contains('Biomas do Jogo'), isTrue);
  });
}

