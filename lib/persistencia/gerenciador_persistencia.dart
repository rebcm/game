import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GerenciadorPersistencia with ChangeNotifier {
  static const String _chaveInventario = 'inventario';
  static const String _chavePosicaoRebeca = 'posicaoRebeca';

  late SharedPreferences _prefs;

  Future<void> inicializar() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Map<String, dynamic> carregarInventario() {
    final inventarioString = _prefs.getString(_chaveInventario);
    if (inventarioString != null) {
      return Map<String, dynamic>.from(inventarioString as Map);
    }
    return {};
  }

  Future<void> salvarInventario(Map<String, dynamic> inventario) async {
    await _prefs.setString(_chaveInventario, inventario.toString());
    notifyListeners();
  }

  Map<String, dynamic> carregarPosicaoRebeca() {
    final posicaoString = _prefs.getString(_chavePosicaoRebeca);
    if (posicaoString != null) {
      return Map<String, dynamic>.from(posicaoString as Map);
    }
    return {};
  }

  Future<void> salvarPosicaoRebeca(Map<String, dynamic> posicao) async {
    await _prefs.setString(_chavePosicaoRebeca, posicao.toString());
    notifyListeners();
  }
}
