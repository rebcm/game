import 'dart:io';

void main() {
  final dicasFile = File('docs/dicas.md');
  final dicasContent = dicasFile.readAsStringSync();

  final estruturasSugeridasDir = Directory('assets/estruturas_sugeridas');
  final estruturasSugeridasFiles = estruturasSugeridasDir.listSync().whereType<File>();

  final matrizConteudo = <String, List<String>>{};

  // Extrair dicas de construção essenciais
  final dicasEssenciais = RegExp(r'## Dicas Essenciais(.*?)##', dotAll: true).firstMatch(dicasContent)?.group(1);
  if (dicasEssenciais != null) {
    matrizConteudo['dicasEssenciais'] = dicasEssenciais.split('\n').where((line) => line.trim().isNotEmpty).map((line) => line.trim()).toList();
  }

  // Extrair estruturas sugeridas
  matrizConteudo['estruturasSugeridas'] = estruturasSugeridasFiles.map((file) => file.path).toList();

  final output = File('docs/matriz_conteudo_dicas.json');
  output.writeAsStringSync(matrizConteudo.toString());
}
