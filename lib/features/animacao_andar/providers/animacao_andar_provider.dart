import 'package:flutter/material.dart';
import 'package:passdriver/features/animacao_andar/models/animacao_andar.dart';

class AnimacaoAndarProvider with ChangeNotifier {
  AnimacaoAndar _animacaoAndar = AnimacaoAndar(fps: 0, sincroniaBracoPerna: 0, loopAtivo: false);

  AnimacaoAndar get animacaoAndar => _animacaoAndar;

  void atualizarAnimacaoAndar(AnimacaoAndar animacaoAndar) {
    _animacaoAndar = animacaoAndar;
    notifyListeners();
  }

  bool get estaDentroDosCriteriosDeAceitacao {
    return _animacaoAndar.fps >= 24 &&
           _animacaoAndar.sincroniaBracoPerna >= 0.8 &&
           _animacaoAndar.loopAtivo;
  }
}
