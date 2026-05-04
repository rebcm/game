class ChunkModel {
  final String data;

  ChunkModel({required this.data});

  factory ChunkModel.fromJson(Map<String, dynamic> json) {
    return ChunkModel(data: json['data']);
  }

  factory ChunkModel.empty() {
    return ChunkModel(data: '');
  }
}
