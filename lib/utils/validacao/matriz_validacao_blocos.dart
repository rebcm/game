import 'package:flutter/foundation.dart';

class MatrizValidacaoBlocos {
  static const List<String> blocosImplementados = [
    // Lista de blocos implementados no código
    'bloco1',
    'bloco2',
    // Adicione mais blocos conforme necessário
  ];

  static const Map<String, String> descricaoBlocos = {
    // Mapeamento de blocos para suas descrições na documentação
    'bloco1': 'Descrição do Bloco 1',
    'bloco2': 'Descrição do Bloco 2',
    // Adicione mais blocos e descrições conforme necessário
  };

  static bool validarBlocos() {
    for (var bloco in blocosImplementados) {
      if (!descricaoBlocos.containsKey(bloco)) {
        return false;
      }
    }
    return true;
  }

  static void imprimirMatrizValidacao() {
    debugPrint('Matriz de Validação de Blocos:');
    for (var bloco in blocosImplementados) {
      debugPrint('$bloco: ${descricaoBlocos[bloco]}');
    }
  }
}
