import 'package:flutter/foundation.dart';
import '../mundo/mundo.dart';
import '../personagem/rebeca.dart';

enum EstadoTela { inicio, jogando, pausado, configuracoes }

class EstadoJogo extends ChangeNotifier {
  EstadoTela tela = EstadoTela.inicio;
  Mundo? mundo;
  Rebeca? rebeca;
  bool mostrarInventario = false;
  int totalBlocosColocados = 0;
  int totalBlocosRemovidos = 0;
  DateTime? inicioSessao;
  String nomeDoMundo = 'Mundo da Rebeca';

  void iniciarJogo({String? nome}) {
    nomeDoMundo = nome ?? 'Mundo da Rebeca';
    mundo = Mundo();
    rebeca = Rebeca(x: 8, y: 25, z: 8);
    inicioSessao = DateTime.now();
    tela = EstadoTela.jogando;
    notifyListeners();
  }

  void pausar() {
    tela = EstadoTela.pausado;
    notifyListeners();
  }

  void retomar() {
    tela = EstadoTela.jogando;
    notifyListeners();
  }

  void voltarInicio() {
    tela = EstadoTela.inicio;
    mundo = null;
    rebeca = null;
    inicioSessao = null;
    notifyListeners();
  }

  void abrirInventario() {
    mostrarInventario = !mostrarInventario;
    notifyListeners();
  }

  void blocoColocado() {
    totalBlocosColocados++;
    notifyListeners();
  }

  void blocoRemovido() {
    totalBlocosRemovidos++;
    notifyListeners();
  }

  Duration get tempoJogando =>
      inicioSessao != null
          ? DateTime.now().difference(inicioSessao!)
          : Duration.zero;
}
