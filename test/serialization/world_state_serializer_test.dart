import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/world_state.dart';
import 'package:game/serialization/world_state_serializer.dart';

void main() {
  test('serialize and deserialize world state', () {
    final worldState = WorldState(blocks: [
      [
        [1, 2, 3],
        [4, 5, 6],
      ],
      [
        [7, 8, 9],
        [10, 11, 12],
      ],
    ]);

    final json = WorldStateSerializer.toJson(worldState);
    final deserializedWorldState = WorldStateSerializer.fromJson(json);

    expect(deserializedWorldState.blocks, worldState.blocks);

    final binary = WorldStateSerializer.toBinary(worldState);
    final deserializedWorldStateFromBinary = WorldStateSerializer.fromBinary(binary);

    expect(deserializedWorldStateFromBinary.blocks, worldState.blocks);
  });
}
