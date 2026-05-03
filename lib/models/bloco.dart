import 'package:json_annotation/json_annotation.dart';

part 'bloco.g.dart';

@JsonSerializable()
class Bloco {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'nome')
  String nome;

  @JsonKey(name: 'descricao')
  String descricao;

  Bloco({required this.id, required this.nome, required this.descricao});

  factory Bloco.fromJson(Map<String, dynamic> json) => _$BlocoFromJson(json);
  Map<String, dynamic> toJson() => _$BlocoToJson(this);
}
