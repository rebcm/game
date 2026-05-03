class Chunk {
  final int x;
  final int z;
  final List<int> data;

  Chunk({required this.x, required this.z, required this.data});

  factory Chunk.fromJson(Map<String, dynamic> json) {
    return Chunk(
      x: json['x'],
      z: json['z'],
      data: List<int>.from(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'z': z,
      'data': data,
    };
  }
}
