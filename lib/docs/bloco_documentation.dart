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

  Bloco({required this.id, required this.descricao});

  factory Bloco.fromJson(Map<String, dynamic> json) {
    return Bloco(id: json['id'], descricao: json['descricao']);
  }
}

void main() {
  // Example usage
  final jsonData = '''
  {
    "blocos": [
      {"id": "1", "descricao": "Bloco 1"},
      {"id": "2", "descricao": "Bloco 2"}
    ]
  }
  ''';

  final Map<String, dynamic> jsonMap = jsonDecode(jsonData);
  final blocoDocumentation = BlocoDocumentation.fromJson(jsonMap);
  print(blocoDocumentation.blocos);
}
