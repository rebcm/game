import 'package:json_annotation/json_annotation.dart';

part 'chunk.g.dart';

@JsonSerializable()
class Chunk {
  final List<dynamic> data;

  Chunk({required this.data});

  factory Chunk.fromJson(Map<String, dynamic> json) => _$ChunkFromJson(json);
  Map<String, dynamic> toJson() => _$ChunkToJson(this);
}
