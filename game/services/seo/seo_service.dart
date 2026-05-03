import 'package:flutter/material.dart';

class SeoService {
  static const List<String> _palavrasChavePrincipais = [
    'Flutter',
    'Voxel',
    'Modo Criativo',
    'Desenvolvimento de Jogos',
  ];

  static const List<String> _palavrasChaveSecundarias = [
    'Jogo de Blocos',
    'Criatividade',
    'Construção',
    'Desenvolvimento de Jogos com Flutter',
  ];

  List<String> get palavrasChavePrincipais => _palavrasChavePrincipais;
  List<String> get palavrasChaveSecundarias => _palavrasChaveSecundarias;
}
