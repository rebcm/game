import 'package:json_annotation/json_annotation.dart';
import 'block_documentation.dart';

part 'block_documentation_list.g.dart';

@JsonSerializable()
class BlockDocumentationList {
  @JsonKey(name: 'blocks')
  List<BlockDocumentation> blocks;

  BlockDocumentationList({required this.blocks});

  factory BlockDocumentationList.fromJson(Map<String, dynamic> json) => _$BlockDocumentationListFromJson(json);
  Map<String, dynamic> toJson() => _$BlockDocumentationListToJson(this);
}
