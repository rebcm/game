class EstruturaSugerida {
  final String nome;
  final String descricao;

  EstruturaSugerida({required this.nome, required this.descricao});
}

class EstruturasSugeridas {
  static List<EstruturaSugerida> estruturas = [
    EstruturaSugerida(nome: 'Casa', descricao: 'Uma casa simples'),
    EstruturaSugerida(nome: 'Castelo', descricao: 'Um castelo medieval'),
    // Adicione mais estruturas sugeridas aqui
  ];
}
