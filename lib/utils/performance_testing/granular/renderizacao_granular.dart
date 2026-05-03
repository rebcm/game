import 'package:flutter/material.dart';

class RenderizacaoGranular with ChangeNotifier {
  int _fps = 0;
  int get fps => _fps;

  void atualizarFPS(int novoFPS) {
    _fps = novoFPS;
    notifyListeners();
  }
}
