import 'dart:convert';
import 'dart:typed_data';
import 'package:game/models/world_state.dart';

class WorldStateSerializer {
  static String toJson(WorldState state) => jsonEncode(state.toJson());

  static WorldState fromJson(String json) => WorldState.fromJson(jsonDecode(json));

  static Uint8List toBinary(WorldState state) {
    final jsonString = toJson(state);
    return Uint8List.fromList(utf8.encode(jsonString));
  }

  static WorldState fromBinary(Uint8List binary) {
    final jsonString = utf8.decode(binary);
    return fromJson(jsonString);
  }
}
