import 'package:json_annotation/json_annotation.dart';

part 'world_payload.g.dart';

@JsonSerializable()
class WorldPayload {
  final String name;

  WorldPayload({required this.name});

  factory WorldPayload.fromJson(String json) {
    if (json.isEmpty) {
      throw FormatException('Payload is empty');
    }
    return WorldPayload.fromJsonMap(jsonDecode(json));
  }

  factory WorldPayload.fromJsonMap(Map<String, dynamic> json) => _$WorldPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$WorldPayloadToJson(this);
}
