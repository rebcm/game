import 'dart:convert';
import 'package:rebcm/api/world_api.dart';
import 'package:rebcm/models/world_request.dart';

class WorldService {
  final WorldApi _worldApi;

  WorldService(this._worldApi);

  Future<bool> createWorld(String userId, String worldData) async {
    final worldRequest = WorldRequest(data: worldData);
    final response = await _worldApi.createWorld(userId, jsonEncode(worldRequest.toJson()));
    return response.statusCode == 201;
  }
}
