import 'dart:io';

void main() {
  final estruturasSugeridasFile = File('./docs/estruturas_sugeridas.md');
  final estruturasSugeridasContent = estruturasSugeridasFile.readAsStringSync();

  // Implemente a lógica para extrair e validar as estruturas sugeridas
  print('Extraindo estruturas sugeridas...');
  print(estruturasSugeridasContent);
}
