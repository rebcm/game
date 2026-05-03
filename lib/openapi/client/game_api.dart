// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:openapi_client/openapi_client.dart';

part 'game_api.g.dart';

/// Game API client
class GameApi with _$GameApi {
  /// Get all blocks
  @GET('/blocks')
  Future<List<Block>> getBlocks();
}

/// Block model
@JsonSerializable()
class Block with _$Block {
  @JsonKey(name: 'id')
  int get id;

  @JsonKey(name: 'name')
  String get name;
}
