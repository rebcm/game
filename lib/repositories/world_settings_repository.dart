import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/world_settings.dart';

class WorldSettingsRepository {
  final String _baseUrl;

  WorldSettingsRepository(this._baseUrl);

  Future<WorldSettings> getWorldSettings(String worldId) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/worlds/$worldId/settings'));

    if (response.statusCode == 200) {
      return WorldSettings.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load world settings');
    }
  }

  Future<WorldSettings> updateWorldSettings(String worldId, WorldSettings settings) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/worlds/$worldId/settings'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(settings.toJson()),
    );

    if (response.statusCode == 200) {
      return WorldSettings.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update world settings');
    }
  }
}
