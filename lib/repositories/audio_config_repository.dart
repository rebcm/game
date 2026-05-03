import 'package:rebcm/datasources/local_storage_datasource.dart';

class AudioConfigRepository {
  final LocalStorageDatasource _localStorageDatasource;

  AudioConfigRepository(this._localStorageDatasource);

  Future<void> saveAudioConfig(Map<String, dynamic> config) async {
    await _localStorageDatasource.saveAudioConfig(config);
  }

  Future<Map<String, dynamic>?> getAudioConfig() async {
    final configStr = await _localStorageDatasource.getAudioConfig();
    // Implementar lógica para converter configStr para Map<String, dynamic>
  }
}

