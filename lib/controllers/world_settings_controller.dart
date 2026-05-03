import '../services/world_settings_service.dart';
import '../models/world_settings.dart';

class WorldSettingsController {
  final WorldSettingsService _service;

  WorldSettingsController(this._service);

  Future<WorldSettings> getWorldSettings(String worldId) => _service.getWorldSettings(worldId);
  Future<WorldSettings> updateWorldSettings(String worldId, WorldSettings settings) => _service.updateWorldSettings(worldId, settings);
}
