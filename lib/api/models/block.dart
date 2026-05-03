import 'package:json_annotation/json_annotation.dart';

part 'block.g.dart';

@JsonSerializable()
class Block {
  int id;
  String name;

  Block({required this.id, required this.name});

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
  Map<String, dynamic> toJson() => _$BlockToJson(this);
}
