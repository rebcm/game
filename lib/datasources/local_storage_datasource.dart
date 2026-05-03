import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDatasource {
  Future<void> saveAudioConfig(Map<String, dynamic> config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('audioConfig', config.toString());
  }

  Future<String?> getAudioConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('audioConfig');
  }

  // Implementar métodos para salvar e recuperar metadados de usuário
}

