import 'package:shared_preferences/shared_preferences.dart';

class GerenciadorPreferencias {
  static const String _chaveMundo = 'mundo';

  Future<void> salvarMundo(String mundo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveMundo, mundo);
  }

  Future<String?> carregarMundo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chaveMundo);
  }
}
