import 'package:flutter/services.dart' rootBundle;
import 'dart:convert';

class AmbienteConfig {
  String _versao = '';

  String get versao => _versao;

  Future<void> carregarConfiguracoes() async {
    final configuracoesJson = await rootBundle.loadString('assets/configuracoes.json');
    final configuracoes = jsonDecode(configuracoesJson);
    _versao = configuracoes['versao'] ?? '';
  }
}
