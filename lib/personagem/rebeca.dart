import 'package:rebcm/personagem/rebecca_animacao.dart';

class Rebeca {
  AnimacaoRebeca _animacao = AnimacaoRebeca();

  void atualizar(double frameRate, double velocidadeTranslacao) {
    _animacao.atualizar(frameRate, velocidadeTranslacao);
    if (!_animacao.estaSincronizada()) {
      // ajustar animação ou velocidade de translação
    }
  }
}
