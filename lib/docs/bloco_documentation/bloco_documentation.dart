import 'dart:convert';

class BlocoDocumentation {
  final List<Bloco> blocos;

  BlocoDocumentation({required this.blocos});

  factory BlocoDocumentation.fromJson(Map<String, dynamic> json) {
    return BlocoDocumentation(
      blocos: (json['blocos'] as List)
          .map((bloco) => Bloco.fromJson(bloco))
          .toList(),
    );
  }
}

class Bloco {
  final String id;
  final String descricao;
  final String categoria;

  Bloco({required this.id, required this.descricao, required this.categoria});

  factory Bloco.fromJson(Map<String, dynamic> json) {
    return Bloco(
      id: json['id'],
      descricao: json['descricao'],
      categoria: json['categoria'],
    );
  }
}
