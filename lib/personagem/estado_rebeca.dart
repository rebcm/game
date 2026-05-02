enum EstadoRebeca {
  parado,
  andando,
}

class MaquinaEstadoRebeca {
  EstadoRebeca _estadoAtual;

  MaquinaEstadoRebeca() : _estadoAtual = EstadoRebeca.parado;

  EstadoRebeca get estado => _estadoAtual;

  void atualizar(bool movimentando) {
    if (movimentando && _estadoAtual == EstadoRebeca.parado) {
      _estadoAtual = EstadoRebeca.andando;
    } else if (!movimentando && _estadoAtual == EstadoRebeca.andando) {
      _estadoAtual = EstadoRebeca.parado;
    }
  }
}
