import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/personagem/rebeca.dart';

class GeradorMovimentacaoRapida {
  static List<Offset> gerarMovimentacaoRapida(int numPassos) {
    List<Offset> movimentacao = [];
    for (int i = 0; i < numPassos; i++) {
      double x = i * 0.1;
      double z = GeradorMundo.gerarAltura(x);
      movimentacao.add(Offset(x, z));
    }
    return movimentacao;
  }
}
