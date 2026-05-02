class MundosDoUsuario {
  final int id;
  final String nome;

  MundosDoUsuario({required this.id, required this.nome});

  factory MundosDoUsuario.fromJson(Map<String, dynamic> json) {
    return MundosDoUsuario(id: json['id'], nome: json['nome']);
  }
}
