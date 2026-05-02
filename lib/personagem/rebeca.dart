import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/personagem/animacao_andar.dart';

class Rebeca with ChangeNotifier {
  bool estaAndando = false;
  final AnimationController animacaoController;
  final Animation<double> bracoAnimacao;
  final Animation<double> pernaAnimacao;

  Rebeca({required TickerProvider vsync})
      : animacaoController = AnimationController(vsync: vsync, duration: const Duration(milliseconds: 500)),
        bracoAnimacao = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animacaoController, curve: Curves.easeInOut)),
        pernaAnimacao = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animacaoController, curve: Curves.easeInOutSine)) {
    bracoAnimacao.addListener(notifyListeners);
    pernaAnimacao.addListener(notifyListeners);
  }

  void andar() {
    estaAndando = true;
    notifyListeners();
  }

  void parar() {
    estaAndando = false;
    notifyListeners();
  }
}
