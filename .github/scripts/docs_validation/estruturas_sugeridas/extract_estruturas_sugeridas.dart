import 'dart:io';

void main() {
  final file = File('lib/docs/estruturas_sugeridas.md');
  final content = file.readAsStringSync();

  // Implemente a lógica para extrair e validar as estruturas sugeridas
  print(content);
}
