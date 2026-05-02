import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VersionadorChunk {
  static const String _chaveVersao = 'versao_chunk';
  static const int versaoAtual = 1;

  static Future<int> carregarVersao() async {
    final prefs = await SharedPreferences.getInstance();
    final versao = prefs.getInt(_chaveVersao);
    return versao ?? 0;
  }

  static Future<void> salvarVersao(int versao) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_chaveVersao, versao);
  }

  static Future<void> atualizarVersao() async {
    final versaoAtual = await carregarVersao();
    if (versaoAtual < VersionadorChunk.versaoAtual) {
      await _aplicarMigracao(versaoAtual);
      await salvarVersao(VersionadorChunk.versaoAtual);
    }
  }

  static Future<void> _aplicarMigracao(int versaoAtual) async {
    if (versaoAtual == 0) {
      await _migrarParaVersao1();
    }
  }

  static Future<void> _migrarParaVersao1() async {
    // Implementar lógica de migração para a versão 1
  }
}
