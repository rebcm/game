class Documentacao {
  final String descricao;
  final String categoria;

  Documentacao({required this.descricao, required this.categoria});

  factory Documentacao.fromJson(Map<String, dynamic> json) {
    return Documentacao(
      descricao: json['descricao'],
      categoria: json['categoria'],
    );
  }
}
