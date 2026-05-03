import 'package:flutter/material.dart';

class BlocoReferencia {
  static List<String> getBlocos() {
    return [
      'grama',
      'terra',
      'pedra',
      'areia',
      'madeira',
      // Adicione outros blocos aqui
    ];
  }

  static void imprimirBlocos() {
    List<String> blocos = getBlocos();
    print('Lista de Blocos:');
    for (var bloco in blocos) {
      print(bloco);
    }
  }
}
