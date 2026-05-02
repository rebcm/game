import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  Future<void> saveProject() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('project', 'Projeto Criado');
  }

  Future<String?> getProject() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('project');
  }
}
