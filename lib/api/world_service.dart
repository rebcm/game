import 'dart:convert';
import 'package:rebcm/api/api_client.dart';
import 'package:rebcm/models/world.dart';

class WorldService {
  final ApiClient _apiClient;

  WorldService(this._apiClient);

  Future<List<World>> getWorlds() async {
    final response = await _apiClient.getWorlds();
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => World.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load worlds');
    }
  }
}
