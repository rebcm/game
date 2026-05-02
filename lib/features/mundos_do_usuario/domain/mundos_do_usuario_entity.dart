class MundosDoUsuarioEntity {
  final String id;
  final String nome;

  MundosDoUsuarioEntity({required this.id, required this.nome});

  factory MundosDoUsuarioEntity.fromJson(Map<String, dynamic> json) {
    return MundosDoUsuarioEntity(id: json['id'], nome: json['nome']);
  }
}
