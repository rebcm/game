import 'dart:io';

void main() {
  final resolucoesFile = File('lib/docs/dicas/resolucoes.md');
  final content = resolucoesFile.readAsStringSync();
  // Implementar lógica para extrair resoluções e dispositivos alvo
  print(content);
}
