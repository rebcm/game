import 'package:flutter/material.dart';

class ConfiguracoesAmbiente with ChangeNotifier {
  String _ambiente = 'producao';

  String get ambiente => _ambiente;

  void mudarAmbiente(String novoAmbiente) {
    _ambiente = novoAmbiente;
    notifyListeners();
  }
}
