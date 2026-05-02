import 'package:flutter/animation.dart';
import 'package:rebcm/config/constantes.dart';

class AnimacaoRebeca {
  static const double _maxDesvio = 0.05; // 5% de desvio máximo permitido
  static const int _quadrosPorSegundoMinimo = 30;

  double _ultimoFrameRate = 0;
  double _velocidadeTranslacao = 0;

  void atualizar(double frameRate, double velocidade) {
    _ultimoFrameRate = frameRate;
    _velocidadeTranslacao = velocidade;
  }

  bool estaSincronizada() {
    double diferencaVelocidade = (_velocidadeTranslacao * Constantes.tamanhoBloco) / _ultimoFrameRate;
    return diferencaVelocidade <= _maxDesvio;
  }
}
