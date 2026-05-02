import 'package:game/personagem/estados/estado_rebeca.dart';

class MaquinaEstadoRebeca {
  EstadoRebeca _estadoAtual;

  MaquinaEstadoRebeca() : _estadoAtual = EstadoParado() {
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
}
