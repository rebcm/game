import 'dart:io';

void main() {
  List<String> estruturasSugeridas = [
    'castelo',
    'casa',
    'ponte',
    'torre',
    'labirinto',
    'jardim',
    'estátua',
    'pirâmide',
    'arena',
    'catedral',
  ];

  File outputFile = File('lib/docs/estruturas_sugeridas.md');
  outputFile.writeAsStringSync('# Estruturas Sugeridas\n\n');
  estruturasSugeridas.forEach((estrutura) {
    outputFile.writeAsStringSync('- $estrutura\n', mode: FileMode.append);
  });
}
