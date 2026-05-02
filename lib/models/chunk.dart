import 'package:json_annotation/json_annotation.dart';

part 'chunk.g.dart';

@JsonSerializable()
class Chunk {
  final int x;
  final int z;
  final List<int> data;

  Chunk({required this.x, required this.z, required this.data});

  factory Chunk.fromJson(Map<String, dynamic> json) => _$ChunkFromJson(json);
  Map<String, dynamic> toJson() => _$ChunkToJson(this);
}
