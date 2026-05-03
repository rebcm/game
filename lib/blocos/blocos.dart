import 'package:flutter/material.dart';

class Bloco {
  final String nome;
  final String descricao;

  Bloco({required this.nome, required this.descricao});
}

class Blocos with ChangeNotifier {
  List<Bloco> _blocos = [
    Bloco(nome: 'Bloco de Pedra', descricao: 'Um bloco básico de pedra.'),
    Bloco(nome: 'Bloco de Madeira', descricao: 'Um bloco feito de madeira.'),
    Bloco(nome: 'Bloco de Terra', descricao: 'Um bloco de terra simples.'),
    Bloco(nome: 'Bloco de Flor', descricao: 'Um bloco decorativo com uma flor.'),
    Bloco(nome: 'Bloco de Árvore', descricao: 'Um bloco que representa uma árvore.'),
    Bloco(nome: 'Bloco de Água', descricao: 'Um bloco que representa água.'),
    Bloco(nome: 'Bloco de Lava', descricao: 'Um bloco perigoso que representa lava.'),
  ];

  List<Bloco> get blocos => _blocos;

  List<Bloco> getBlocosPorCategoria(String categoria) {
    // Implementar lógica para categorizar blocos
    return _blocos;
  }
}

