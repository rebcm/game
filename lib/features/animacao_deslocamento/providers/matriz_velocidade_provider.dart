import 'package:flutter/material.dart';
import 'package:passdriver/features/animacao_deslocamento/models/matriz_velocidade.dart';

class MatrizVelocidadeProvider with ChangeNotifier {
  List<MatrizVelocidade> _matrizVelocidade = [];

  List<MatrizVelocidade> get matrizVelocidade => _matrizVelocidade;

  void carregarMatrizVelocidade() {
    _matrizVelocidade = [
      MatrizVelocidade(velocidadeDeslocamento: 0.0, velocidadeReproducao: 1.0),
      MatrizVelocidade(velocidadeDeslocamento: 5.0, velocidadeReproducao: 1.2),
      MatrizVelocidade(velocidadeDeslocamento: 10.0, velocidadeReproducao: 1.5),
      MatrizVelocidade(velocidadeDeslocamento: 15.0, velocidadeReproducao: 1.8),
      MatrizVelocidade(velocidadeDeslocamento: 20.0, velocidadeReproducao: 2.0),
    ];
    notifyListeners();
  }
}
