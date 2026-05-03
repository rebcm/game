import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/world_state.dart';
import 'package:game/serializers/world_state_serializer.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('serializes and deserializes WorldState to and from JSON', (tester) async {
    final state = WorldState(blocks: [1, 2, 3], playerX: 0, playerY: 0, playerZ: 0);
    final json = WorldStateSerializer.toJson(state);
    final deserializedState = WorldStateSerializer.fromJson(json);
    expect(deserializedState, state);
  });

  testWidgets('serializes and deserializes WorldState to and from binary', (tester) async {
    final state = WorldState(blocks: [1, 2, 3], playerX: 0, playerY: 0, playerZ: 0);
    final binary = WorldStateSerializer.toBinary(state);
    final deserializedState = WorldStateSerializer.fromBinary(binary);
    expect(deserializedState, state);
  });
}
