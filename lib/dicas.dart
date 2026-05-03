class Dica {
  final String titulo;
  final String descricao;

  Dica({required this.titulo, required this.descricao});
}

class Dicas {
  List<Dica> getDicas() {
    return [
      Dica(titulo: 'Construção Básica', descricao: 'Comece com blocos simples'),
      Dica(titulo: 'Estruturas Complexas', descricao: 'Use diferentes tipos de blocos'),
    ];
  }
}

class EstruturaSugerida {
  final String nome;
  final String descricao;

  EstruturaSugerida({required this.nome, required this.descricao});
}

class EstruturasSugeridas {
  List<EstruturaSugerida> getEstruturas() {
    return [
      EstruturaSugerida(nome: 'Casa Simples', descricao: 'Construa uma casa básica'),
      EstruturaSugerida(nome: 'Castelo', descricao: 'Construa um castelo complexo'),
    ];
  }
}
