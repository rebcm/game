import 'package:json_annotation/json_annotation.dart';

part 'chunk_model.g.dart';

@JsonSerializable()
class ChunkModel {
  final String id;
  final String data;

  ChunkModel({required this.id, required this.data});

  factory ChunkModel.fromJson(Map<String, dynamic> json) => _$ChunkModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChunkModelToJson(this);
}
