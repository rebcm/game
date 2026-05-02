enum EstadoRebeca {
  parado,
  andando,
}

class TransicaoEstadoRebeca {
  EstadoRebeca estadoAtual;
  bool inputMovimentacao;

  TransicaoEstadoRebeca({required this.estadoAtual, required this.inputMovimentacao});

  EstadoRebeca transicionar() {
    if (inputMovimentacao && estadoAtual == EstadoRebeca.parado) {
      return EstadoRebeca.andando;
    } else if (!inputMovimentacao && estadoAtual == EstadoRebeca.andando) {
      return EstadoRebeca.parado;
    }
    return estadoAtual;
  }
}
