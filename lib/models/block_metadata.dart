import 'package:json_annotation/json_annotation.dart';

part 'block_metadata.g.dart';

@JsonSerializable()
class BlockMetadata {
  final String name;
  final String description;

  BlockMetadata({required this.name, required this.description});

  factory BlockMetadata.fromJson(Map<String, dynamic> json) => _$BlockMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$BlockMetadataToJson(this);
}
