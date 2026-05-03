class EstruturaSugerida {
  String nome;
  String descricao;
  List<Bloco> blocos;

  EstruturaSugerida({required this.nome, required this.descricao, required this.blocos});

  factory EstruturaSugerida.fromJson(Map<String, dynamic> json) {
    return EstruturaSugerida(
      nome: json['nome'],
      descricao: json['descricao'],
      blocos: (json['blocos'] as List).map((b) => Bloco.fromJson(b)).toList(),
    );
  }
}

class Bloco {
  String tipo;
  int quantidade;

  Bloco({required this.tipo, required this.quantidade});

  factory Bloco.fromJson(Map<String, dynamic> json) {
    return Bloco(tipo: json['tipo'], quantidade: json['quantidade']);
  }
}
