import 'dart:convert';
import 'chunk.pb.dart';

class Chunk {
  List<int> data = [];

  void init() {
    for (int i = 0; i < 1000; i++) {
      data.add(i % 256);
    }
  }

  Map<String, dynamic> toJson() {
    return {'data': data};
  }

  factory Chunk.fromJson(Map<String, dynamic> json) {
    Chunk chunk = Chunk();
    chunk.data = List<int>.from(json['data']);
    return chunk;
  }

  List<int> writeToBuffer() {
    ChunkPb chunkPb = ChunkPb()..data = data;
    return chunkPb.writeToBuffer();
  }

  factory Chunk.fromBuffer(List<int> buffer) {
    ChunkPb chunkPb = ChunkPb.fromBuffer(buffer);
    Chunk chunk = Chunk();
    chunk.data = chunkPb.data;
    return chunk;
  }
}
