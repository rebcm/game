import 'package:freezed/freezed.dart';

part 'world_state.freezed.dart';
part 'world_state.g.dart';

@freezed
class WorldState with _$WorldState {
  const factory WorldState({
    required List<int> blocks,
    required int playerX,
    required int playerY,
    required int playerZ,
  }) = _WorldState;

  factory WorldState.fromJson(Map<String, Object?> json) => _$WorldStateFromJson(json);
}
