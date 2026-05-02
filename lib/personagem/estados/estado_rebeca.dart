abstract class EstadoRebeca {
  void entrar();
  void atualizar();
  void sair();
}

class EstadoParado extends EstadoRebeca {
  @override
  void entrar() {}

  @override
  void atualizar() {}

  @override
  void sair() {}
}

class EstadoPulando extends EstadoRebeca {
  @override
  void entrar() {}

  @override
  void atualizar() {}

  @override
  void sair() {}
}

class EstadoVoando extends EstadoRebeca {
  @override
  void entrar() {}

  @override
  void atualizar() {}

  @override
  void sair() {}
}
