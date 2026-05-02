import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/mundo/gerador.dart';

class LogicaBlocos with ChangeNotifier {
  void colocarBloco(TipoBloco tipo, int x, int y, int z) {
    GeradorMundo.colocarBloco(tipo, x, y, z);
    notifyListeners();
  }

  void quebrarBloco(int x, int y, int z) {
    GeradorMundo.quebrarBloco(x, y, z);
    notifyListeners();
  }
}
