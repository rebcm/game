class World {
  final String id;
  final String name;

  World({required this.id, required this.name});

  factory World.fromJson(Map<String, dynamic> json) {
    return World(id: json['id'], name: json['name']);
  }
}
