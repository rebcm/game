import 'package:flutter/material.dart';
import 'package:passdriver/features/fisica_3d/models/objeto_3d.dart';

class FisicaProvider with ChangeNotifier {
  List<Objeto3D> _objetos = [];

  List<Objeto3D> get objetos => _objetos;

  void adicionarObjeto(Objeto3D objeto) {
    _objetos.add(objeto);
    notifyListeners();
  }

  void removerObjeto(Objeto3D objeto) {
    _objetos.remove(objeto);
    notifyListeners();
  }
}
