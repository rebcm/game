import 'package:flutter/material.dart';

class Rebeca with ChangeNotifier {
  // Estado da Rebeca
  double _x = 0, _y = 0, _z = 0;
  double _velocidadeX = 0, _velocidadeZ = 0;
  bool _pulando = false;
  bool _voando = false;

  // Getters
  double get x => _x;
  double get y => _y;
  double get z => _z;

  // Método para atualizar a posição
  void atualizarPosicao() {
    _x += _velocidadeX;
    _z += _velocidadeZ;
    // Aplicar gravidade se não estiver voando
    if (!_voando) {
      // Simulação simples de gravidade
    }
    notifyListeners();
  }

  // Método para mover
  void mover(double dx, double dz) {
    _velocidadeX = dx;
    _velocidadeZ = dz;
    notifyListeners();
  }

  // Método para pular
  void pular() {
    if (!_pulando && !_voando) {
      _pulando = true;
      // Lógica para pular
      notifyListeners();
    }
  }

  // Método para voar (modo criativo)
  void voar() {
    _voando = !_voando;
    notifyListeners();
  }

  // Animações
  String getAnimacao() {
    if (_voando) return 'voar';
    if (_pulando) return 'pular';
    if (_velocidadeX != 0 || _velocidadeZ != 0) return 'andar';
    return 'idle';
  }
}
