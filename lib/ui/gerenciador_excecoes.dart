import 'package:flutter/material.dart';

class GerenciadorExcecoes with ChangeNotifier {
  String? _mensagemErro;

  String? get mensagemErro => _mensagemErro;

  void lidarComExcecao(dynamic excecao) {
    _mensagemErro = 'Erro: $excecao';
    notifyListeners();
  }

  void limparErro() {
    _mensagemErro = null;
    notifyListeners();
  }
}
