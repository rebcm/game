import 'package:flutter/material.dart';

class Rebeca with ChangeNotifier {
  double _x = 0, _y = 0, _z = 0;
  double _velocidadeX = 0, _velocidadeZ = 0;
  bool _pulando = false;
  bool _voando = false;

  double get x => _x;
  double get y => _y;
  double get z => _z;

  void mover(double dx, double dz) {
    _velocidadeX = dx;
    _velocidadeZ = dz;
    _x += dx;
    _z += dz;
    notifyListeners();
  }

  void pular() {
    if (!_pulando) {
      _pulando = true;
      _y += 1;
      notifyListeners();
      Future.delayed(Duration(milliseconds: 500), () {
        _pulando = false;
        _y -= 1;
        notifyListeners();
      });
    } else if (!_voando) {
      _voando = true;
      notifyListeners();
    }
  }

  void interagirComBloco(bool quebrar) {
    // Lógica para interagir com bloco
    notifyListeners();
  }

  void atualizar() {
    if (_voando) {
      _y += 0.1;
      notifyListeners();
    }
  }
}
