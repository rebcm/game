import 'package:flutter/material.dart';

class Rebeca with ChangeNotifier {
  String _estado = 'Idle';

  String get estado => _estado;

  void mover() {
    _estado = 'Walking';
    notifyListeners();
  }

  void parar() {
    _estado = 'Idle';
    notifyListeners();
  }
}
