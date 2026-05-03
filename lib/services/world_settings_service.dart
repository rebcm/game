import '../repositories/world_settings_repository.dart';
import '../models/world_settings.dart';

class WorldSettingsService {
  final WorldSettingsRepository _repository;

  WorldSettingsService(this._repository);

  Future<WorldSettings> getWorldSettings(String worldId) => _repository.getWorldSettings(worldId);
  Future<WorldSettings> updateWorldSettings(String worldId, WorldSettings settings) => _repository.updateWorldSettings(worldId, settings);
}
