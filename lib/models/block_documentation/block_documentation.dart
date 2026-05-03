import 'package:json_annotation/json_annotation.dart';

part 'block_documentation.g.dart';

@JsonSerializable()
class BlockDocumentation {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'description')
  String description;

  BlockDocumentation({required this.id, required this.name, required this.description});

  factory BlockDocumentation.fromJson(Map<String, dynamic> json) => _$BlockDocumentationFromJson(json);
  Map<String, dynamic> toJson() => _$BlockDocumentationToJson(this);
}
