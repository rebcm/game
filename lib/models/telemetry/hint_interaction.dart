import 'package:json_annotation/json_annotation.dart';

part 'hint_interaction.g.dart';

@JsonSerializable()
class HintInteraction {
  final String hintId;
  final bool displayed;
  final bool ignored;

  HintInteraction({required this.hintId, required this.displayed, required this.ignored});

  factory HintInteraction.fromJson(Map<String, dynamic> json) => _$HintInteractionFromJson(json);
  Map<String, dynamic> toJson() => _$HintInteractionToJson(this);
}
