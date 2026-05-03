class EstruturasSugeridas {
  static List<Estrutura> getEstruturas() {
    return [
      Estrutura('Casa Simples', 'Uma casa básica com paredes de madeira e um telhado de folhas.', ['10 Blocos de Madeira', '5 Blocos de Folhas']),
      Estrutura('Torre Alta', 'Uma torre alta feita de pedra.', ['20 Blocos de Pedra']),
      Estrutura('Jardim', 'Um jardim com flores e grama.', ['15 Blocos de Grama', '5 Blocos de Flores']),
    ];
  }
}

class Estrutura {
  final String nome;
  final String descricao;
  final List<String> materiais;

  Estrutura(this.nome, this.descricao, this.materiais);
}
