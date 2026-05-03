import 'package:game/database/repositories/performance_index_repository.dart';

class PerformanceService {
  final PerformanceIndexRepository _performanceIndexRepository;

  PerformanceService(this._performanceIndexRepository);

  Future<void> createPerformanceIndex(PerformanceIndex performanceIndex) async {
    await _performanceIndexRepository.createPerformanceIndex(performanceIndex);
  }

  Future<List<PerformanceIndex>> getPerformanceIndexesByWorldId(int worldId) async {
    return await _performanceIndexRepository.getPerformanceIndexesByWorldId(worldId);
  }
}
