import 'package:flutter/material.dart';

class MapeamentoContexto {
  static List<String> telasComDicas = [
    'TelaInicial',
    'TelaConstrucao',
  ];

  static Map<String, List<String>> gatilhosDicas = {
    'TelaInicial': ['botaoIniciarConstrucao'],
    'TelaConstrucao': ['acaoConstruirBloco', 'acaoRemoverBloco'],
  };

  static bool deveMostrarDica(String telaAtual, String? gatilho) {
    if (!telasComDicas.contains(telaAtual)) return false;
    if (gatilho == null) return false;
    return gatilhosDicas[telaAtual]?.contains(gatilho) ?? false;
  }

  static String? tipoDica(String telaAtual, String gatilho) {
    if (telaAtual == 'TelaInicial' && gatilho == 'botaoIniciarConstrucao') {
      return 'Modal';
    } else if (telaAtual == 'TelaConstrucao' &&
        (gatilho == 'acaoConstruirBloco' || gatilho == 'acaoRemoverBloco')) {
      return 'Tooltip';
    }
    return null;
  }
}
