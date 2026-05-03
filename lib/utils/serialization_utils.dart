import 'dart:typed_data';
import '../models/world_state.dart';
import '../serialization/world_state_serializer.dart';

class SerializationUtils {
  static Uint8List serializeWorldState(WorldState worldState) {
    return WorldStateSerializer.toBinary(worldState);
  }

  static WorldState deserializeWorldState(Uint8List binary) {
    return WorldStateSerializer.fromBinary(binary);
  }
}
