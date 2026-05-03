import 'package:json_annotation/json_annotation.dart';

part 'chunk_model.g.dart';

@JsonSerializable()
class ChunkModel {
  @JsonKey(name: 'x')
  final int x;

  @JsonKey(name: 'z')
  final int z;

  @JsonKey(name: 'data')
  final List<int> data;

  ChunkModel({required this.x, required this.z, required this.data});

  factory ChunkModel.fromJson(Map<String, dynamic> json) => _$ChunkModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChunkModelToJson(this);
}
