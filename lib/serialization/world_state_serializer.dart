import 'dart:convert';
import 'dart:typed_data';
import '../models/world_state.dart';

class WorldStateSerializer {
  static String toJson(WorldState worldState) {
    return jsonEncode(worldState.toJson());
  }

  static WorldState fromJson(String json) {
    return WorldState.fromJson(jsonDecode(json));
  }

  static Uint8List toBinary(WorldState worldState) {
    return utf8.encode(toJson(worldState));
  }

  static WorldState fromBinary(Uint8List binary) {
    return fromJson(utf8.decode(binary));
  }
}
