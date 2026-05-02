import 'package:shared_preferences/shared_preferences.dart';

class Persistencia {
  static late SharedPreferences _prefs;

  static Future<void> inicializar() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> salvarValor(String chave, String valor) async {
    await _prefs.setString(chave, valor);
  }

  static String? obterValor(String chave) {
    return _prefs.getString(chave);
  }

  static Future<void> carregarValores() async {
    // Implementação existente ou necessária para carregar valores
  }
}
