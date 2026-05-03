class ChunkResponse {
  final List<int> data;

  ChunkResponse({required this.data});

  factory ChunkResponse.fromJson(Map<String, dynamic> json) {
    return ChunkResponse(data: List<int>.from(json['data']));
  }
}
