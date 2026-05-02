import 'package:rebcm/config/config_compressao.dart';

class AnalisadorQualidade {
  static double analisarQualidade(List<int> dadosOriginais, List<int> dadosComprimidos) {
    // Implementação da análise de qualidade
    // Deve respeitar ConfigCompressao.limitePerdaQualidade
    // Por simplicidade, vamos considerar uma implementação básica
    // que compara a similaridade entre os dados originais e comprimidos
    double diferenca = 0;
    for (int i = 0; i < dadosComprimidos.length; i++) {
      diferenca += (dadosOriginais[i] - dadosComprimidos[i]).abs();
    }
    return diferenca / dadosOriginais.length;
  }
}
