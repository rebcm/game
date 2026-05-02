enum EstadoRebeca {
  parado,
  andando,
}

class RebecaState {
  EstadoRebeca estado;

  RebecaState({this.estado = EstadoRebeca.parado});

  void atualizarEstado(bool movimentando) {
    estado = movimentando ? EstadoRebeca.andando : EstadoRebeca.parado;
  }
}
