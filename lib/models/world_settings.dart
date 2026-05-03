import 'package:json_annotation/json_annotation.dart';

part 'world_settings.g.dart';

@JsonSerializable()
class WorldSettings {
  final int seed;
  final int chunkSize;
  final int renderDistance;

  WorldSettings({required this.seed, required this.chunkSize, required this.renderDistance});

  factory WorldSettings.fromJson(Map<String, dynamic> json) => _$WorldSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$WorldSettingsToJson(this);
}
