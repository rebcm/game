enum EstadoRebeca {
  parado,
  andando,
}

class TransicaoEstadoRebeca {
  EstadoRebeca estadoAtual;
  bool movimentoPressionado;

  TransicaoEstadoRebeca(this.estadoAtual, this.movimentoPressionado);

  EstadoRebeca proximoEstado() {
    if (movimentoPressionado && estadoAtual == EstadoRebeca.parado) {
      return EstadoRebeca.andando;
    } else if (!movimentoPressionado && estadoAtual == EstadoRebeca.andando) {
      return EstadoRebeca.parado;
    }
    return estadoAtual;
  }
}
