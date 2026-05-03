import 'package:flutter/material.dart';
import 'package:rebcm/game.dart';

void main() {
  final dicas = Dicas();
  final strings = dicas.getAllStrings();
  print(strings.join('\n'));
}

class Dicas {
  List<String> getAllStrings() {
    // TO DO: Implementação para extrair todas as strings de dicas do projeto
    // Deve ser baseado na estrutura existente no código
    return [];
  }
}
