class Mundo {
  final String id;
  final String usuarioId;

  Mundo({required this.id, required this.usuarioId});

  factory Mundo.fromJson(Map<String, dynamic> json) {
    return Mundo(id: json['id'], usuarioId: json['usuarioId']);
  }
}
