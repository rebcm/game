class WorldModel {
  final int id;
  final String r2;
  final int timestamp;

  WorldModel({required this.id, required this.r2, required this.timestamp});

  factory WorldModel.fromMap(Map<String, Object?> map) {
    return WorldModel(
      id: map['id'] as int,
      r2: map['r2'] as String,
      timestamp: map['timestamp'] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'r2': r2,
      'timestamp': timestamp,
    };
  }
}
