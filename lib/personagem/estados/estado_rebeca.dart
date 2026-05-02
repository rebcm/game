import 'package:flutter/material.dart';

abstract class EstadoRebeca {
  void entrar();
  void sair();
  void atualizar();
  Widget renderizar();
}

class EstadoParado extends EstadoRebeca {
  @override
  void entrar() {}

  @override
  void sair() {}

  @override
  void atualizar() {}

  @override
  Widget renderizar() {
    return Container(); // Implementar renderização para estado parado
  }
}

class EstadoPulando extends EstadoRebeca {
  @override
  void entrar() {}

  @override
  void sair() {}

  @override
  void atualizar() {}

  @override
  Widget renderizar() {
    return Container(); // Implementar renderização para estado pulando
  }
}

class MaquinaEstadosRebeca {
  EstadoRebeca _estadoAtual;

  MaquinaEstadosRebeca() : _estadoAtual = EstadoParado() {
    _estadoAtual.entrar();
  }

  void mudarEstado(EstadoRebeca novoEstado) {
    _estadoAtual.sair();
    _estadoAtual = novoEstado;
    _estadoAtual.entrar();
  }

  void atualizar() {
    _estadoAtual.atualizar();
  }

  Widget renderizar() {
    return _estadoAtual.renderizar();
  }
}
